part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSucessful extends RegisterState {}

class Registerailuer extends RegisterState {
 final String errorMessage;

  Registerailuer({required this.errorMessage});
}
