part of 'get_doctors_cubit.dart';

@immutable
sealed class GetDoctorsState {}

final class GetDoctorsInitial extends GetDoctorsState {}

final class GetDoctorsLoading extends GetDoctorsState {}

final class GetDoctorsSuccess extends GetDoctorsState {}

final class GetDoctorsFailure extends GetDoctorsState {
  final String errorMessage;

  GetDoctorsFailure({required this.errorMessage});
}
