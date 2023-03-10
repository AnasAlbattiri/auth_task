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

// join group
class JoinGroupSuccessState extends AppState {}

class JoinGroupErrorState extends AppState
{
  final String error;

  JoinGroupErrorState(this.error);
}

// get joined users

class GetJoinedUsersSuccessState extends AppState {}

class GetJoinedUsersErrorState extends AppState
{
  final String error;

  GetJoinedUsersErrorState(this.error);
}