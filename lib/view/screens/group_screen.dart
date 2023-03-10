import 'package:flutter/material.dart';
import 'package:three_stars_task/view/screens/joined_screen.dart';
import '../../business_logic/cubit/app_cubit.dart';
import '../../data/model/joined.dart';
import '../../data/model/user.dart';
import '../../utils/constants.dart';

class GroupScreen extends StatelessWidget {
  GroupScreen({Key? key}) : super(key: key);

  Joined? groupModel;
  User? userModel;

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
        title: Text(
          'Group',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            if(AppCubit.get(context).joinedUsers?.length == 3){
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Center(
                                    child: Text(
                                      'You can\'t join, Group is full.',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else if (AppCubit.get(context).joinedUsers?.length == 4){
                                AppCubit.get(context).joinedUsers?.length--;
                            } else {
                              navigateAndFinish(context, JoinedScreen());
                              AppCubit.get(context).joinGroup(
                                name: auth.currentUser?.displayName,
                                uId: auth.currentUser?.uid,
                              );
                              AppCubit.get(context).getJoinedUsers();
                            }
                          },
                          child: Text(
                            'Join',
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
                    'Group of 3 users',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              );
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    backgroundImage: NetworkImage(
                        'https://th.bing.com/th/id/OIP.Ro6ih6nc8V5gAw4bEtOO_AAAAA?pid=ImgDet&rs=1'),
                    radius: 46,
                  ),
                ),
                Text(
                  'Group of 3 users',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
