part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSucessful extends LoginState {}

class LoginFailuer extends LoginState {
  final String errorMessage;

  LoginFailuer({required this.errorMessage});
}
