part of 'location_cubit.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationSuccess extends LocationState {
  final double latitude;
  final double longitude;
  final String timestamp;

  LocationSuccess(this.latitude, this.longitude, this.timestamp);
}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);
}
