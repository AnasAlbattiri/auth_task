import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_stars_task/business_logic/cubit/app_cubit.dart';
import '../../../utils/constants.dart';
import '../../widgets/background.dart';
import '../../widgets/login/login_form.dart';
import '../../widgets/login/login_screen_top_image.dart';
import '../group_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        return Background(
          child: SingleChildScrollView(
            child: MobileLoginScreen(),
          ),
        );
      },
      listener: (context, state) {
        if(state is LoginSuccessState){
          navigateAndFinish(context, GroupScreen());
        }
      },
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const LoginScreenTopImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
