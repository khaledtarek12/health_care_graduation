part of 'get_patient_cubit.dart';

@immutable
sealed class GetPatientsState {}

final class GetPatientsInitial extends GetPatientsState {}

final class GetPatientsLoading extends GetPatientsState {}

final class GetPatientsSuccess extends GetPatientsState {}

final class GetPatientsFailure extends GetPatientsState {
  final String errorMessage;

  GetPatientsFailure({required this.errorMessage});
}
