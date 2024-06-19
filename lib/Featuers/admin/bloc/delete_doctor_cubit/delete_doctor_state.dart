part of 'delete_doctor_cubit.dart';

@immutable
sealed class DeleteDoctorState {}

final class DeleteDoctorInitial extends DeleteDoctorState {}

final class DeleteDoctorLoading extends DeleteDoctorState {}

final class DeleteDoctorSuccess extends DeleteDoctorState {}

final class DeleteDoctorFailure extends DeleteDoctorState {
  final String errorMessage;

  DeleteDoctorFailure({required this.errorMessage});
}
