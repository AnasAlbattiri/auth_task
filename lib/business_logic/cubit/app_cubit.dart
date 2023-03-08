import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:three_stars_task/view/screens/group_screen.dart';
import 'package:three_stars_task/view/screens/welcome_screen.dart';

import '../../utils/constants.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(Initial());

  static AppCubit get(context) => BlocProvider.of(context);

  void logInUsingFirebase ({
    required String email,
    required String password,
    required BuildContext context,
  }) async
  {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
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

  void signUpUsingFirebase(String email, String password, BuildContext context) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        emit(SignupSuccessState());
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
      emit(SignupErrorState(error.toString()));
    }
  }


  void signOut(BuildContext context) async {
    await auth.signOut();
    navigateAndFinish(context, WelcomeScreen());
  }
}
