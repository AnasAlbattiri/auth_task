import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_stars_task/business_logic/cubit/app_cubit.dart';
import 'package:three_stars_task/view/screens/group_screen.dart';
import '../../../utils/constants.dart';
import '../../widgets/background.dart';
import '../../widgets/signup/sign_up_top_image.dart';
import '../../widgets/signup/signup_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        builder: (context, state) {
          return Background(
            child: SingleChildScrollView(
              child: MobileSignupScreen(),
            ),
          );
        },
        listener: (context, state) {
          if(state is SignupSuccessState){
            navigateAndFinish(context, GroupScreen());
          }
        });
  }
}

class MobileSignupScreen extends StatefulWidget {
  const MobileSignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MobileSignupScreen> createState() => _MobileSignupScreenState();
}

class _MobileSignupScreenState extends State<MobileSignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SignUpScreenTopImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: SignUpForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
