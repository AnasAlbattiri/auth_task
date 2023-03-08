import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_stars_task/business_logic/cubit/app_cubit.dart';
import 'package:three_stars_task/view/screens/group_screen.dart';
import 'package:three_stars_task/view/screens/auth/login_screen.dart';
import 'package:three_stars_task/view/screens/auth/signup_screen.dart';
import 'package:three_stars_task/view/screens/welcome_screen.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AppCubit(),
          child: SignUpScreen(),
        ),
        BlocProvider(
          create: (_) => AppCubit(),
          child: LoginScreen(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Auth',
              theme: ThemeData(
                  primaryColor: kPrimaryColor,
                  scaffoldBackgroundColor: Colors.white,
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: kPrimaryColor,
                      shape: const StadiumBorder(),
                      maximumSize: const Size(double.infinity, 56),
                      minimumSize: const Size(double.infinity, 56),
                    ),
                  ),
                  inputDecorationTheme: const InputDecorationTheme(
                    filled: true,
                    fillColor: kPrimaryLightColor,
                    iconColor: kPrimaryColor,
                    prefixIconColor: kPrimaryColor,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: defaultPadding, vertical: defaultPadding),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide.none,
                    ),
                  )),
              home: auth.currentUser != null ? GroupScreen() : WelcomeScreen(),
            );
          },
      ),
    );
  }
}
