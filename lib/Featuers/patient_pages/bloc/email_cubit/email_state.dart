part of 'email_cubit.dart';

@immutable
abstract class EmailState {}

class EmailInitial extends EmailState {}

class EmailLoading extends EmailState {}

class EmailSuccess extends EmailState {}

class EmailFailure extends EmailState {
  final String errorMessage;

  EmailFailure({required this.errorMessage});
}
