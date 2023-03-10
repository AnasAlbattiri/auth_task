import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_stars_task/utils/constants.dart';
import 'package:three_stars_task/view/widgets/background.dart';
import 'package:three_stars_task/view/widgets/has_joined.dart';
import '../../business_logic/cubit/app_cubit.dart';
import '../../data/model/user.dart';

class JoinedScreen extends StatelessWidget {
  JoinedScreen({Key? key}) : super(key: key);

  User? userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Joined',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () {
                            AppCubit.get(context).signOut(context);
                          },
                          child: Text(
                            'Yes',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Close',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  title: Center(
                    child: Text(
                      'Logout From App',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  contentPadding: EdgeInsets.only(
                    top: 6,
                  ),
                  content: Text(
                    '   Are you sure you need to logout?',
                    style: TextStyle(
                      fontSize: 15,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is JoinGroupSuccessState) {
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(18.0),
                child: hasJoined(AppCubit.get(context).joinedUsers![index]),
              ),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: AppCubit.get(context).joinedUsers!.length,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

