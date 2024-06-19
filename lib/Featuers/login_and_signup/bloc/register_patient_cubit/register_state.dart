part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSucessful extends RegisterState {}

class RegisterFailuer extends RegisterState {
  final String errorMessage;

  RegisterFailuer({required this.errorMessage});
}
