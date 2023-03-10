import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:three_stars_task/data/model/user.dart' as model;
import 'package:three_stars_task/view/screens/group_screen.dart';
import 'package:three_stars_task/view/screens/welcome_screen.dart';
import '../../data/model/joined.dart';
import '../../utils/constants.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(Initial());

  static AppCubit get(context) => BlocProvider.of(context);

  var displayUserName = '';
  List<Joined>? joinedUsers;
  Joined? joined;

  // FIREBASE AUTH
  void logInUsingFirebase ({
    required String email,
    required String password,
    required BuildContext context,
  }) async
  {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
          displayUserName = auth.currentUser!.displayName!;
        });
        emit(LoginSuccessState());
        navigateTo(context, GroupScreen());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error Creating Account, Please enter all the fields.'),
            backgroundColor: Colors.black,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(5),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${error.toString()}'),
          backgroundColor: Colors.black,
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        ),
      );
      emit(LoginErrorState(error.toString()));
    }
  }

  void signUpUsingFirebase(String name, String email, String password, BuildContext context) async {
    try {
      if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ).then((value) {
          displayUserName = name;
          auth.currentUser!.updateDisplayName(name);
          return value;
        });
        emit(SignupSuccessState());
        navigateTo(context, GroupScreen());
        model.User user = model.User(
          name: name,
          email: email,
          uid: cred.user!.uid,
        );
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error Creating Account, Please enter all the fields.'),
            backgroundColor: Colors.black,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(5),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${error.toString()}'),
          backgroundColor: Colors.black,
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        ),
      );
      emit(SignupErrorState(error.toString()));
    }
  }


  void signOut(BuildContext context) async {
    await auth.signOut();
    navigateAndFinish(context, WelcomeScreen());
  }


  // JOIN GROUP
  void joinGroup({
  required String? name,
  required String? uId,
}){
    Joined joinedModel = Joined(
      name: name,
      uId: uId,
    );
    firestore.collection('users joined')
        .add(joinedModel.toJson())
        .then((value)
    {
      emit(JoinGroupSuccessState());
    }).catchError((error)
    {
      emit(JoinGroupErrorState(error.toString()));
    });
  }

  void getJoinedUsers(){
    joinedUsers = [];
    firestore.collection('users joined').get().then((value)
    {
      value.docs.forEach((element)
      {
        joinedUsers?.add(Joined.fromJson(element.data()));
      });
      emit(GetJoinedUsersSuccessState());
    }).catchError((error)
    {
      emit(GetJoinedUsersErrorState(error.toString()));
    });
  }

}
