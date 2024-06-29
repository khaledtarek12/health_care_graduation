part of 'get_patient_location_cubit.dart';


abstract class GetPatientLocationState {}

class GetPatientLocationInitial extends GetPatientLocationState {}

class GetPatientLocationLoading extends GetPatientLocationState {}

class GetPatientLocationSuccess extends GetPatientLocationState {
  final double latitude;
  final double longitude;
  final String timestamp;

  GetPatientLocationSuccess(this.latitude, this.longitude, this.timestamp);
}

class GetPatientLocationFailure extends GetPatientLocationState {
  final String errorMessage;

  GetPatientLocationFailure(this.errorMessage);
}
class GetAllPatientsLocationsSuccess extends GetPatientLocationState {
  final Map<String, Map<String, dynamic>> latestLocations;

  GetAllPatientsLocationsSuccess(this.latestLocations);
}