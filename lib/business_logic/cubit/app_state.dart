part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class Initial extends AppState {}

// login states
class LoginSuccessState extends AppState {}

class LoginErrorState extends AppState
{
  final String error;

  LoginErrorState(this.error);
}


// signup states
class SignupSuccessState extends AppState {}

class SignupErrorState extends AppState
{
  final String error;

  SignupErrorState(this.error);
}