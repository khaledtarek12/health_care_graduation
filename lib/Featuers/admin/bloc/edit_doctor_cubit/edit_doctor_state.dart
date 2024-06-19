part of 'edit_doctor_cubit.dart';

@immutable
sealed class EditDoctorState {}

final class EditDoctorInitial extends EditDoctorState {}

final class EditDoctorLoading extends EditDoctorState {}

final class EditDoctorSucess extends EditDoctorState {}

final class EditDoctorFailure extends EditDoctorState {
  final String errorMessage;

  EditDoctorFailure({required this.errorMessage});
}
