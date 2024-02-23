part of 'alarm_data_cubit.dart';

@immutable
sealed class AlarmDataState {}

final class AlarmDataInitial extends AlarmDataState {}

final class AlarmDataLoading extends AlarmDataState {}

final class AlarmDataSuccesful extends AlarmDataState {
}

final class AlarmDataFailuer extends AlarmDataState {
  final String errorMessage;

  AlarmDataFailuer({required this.errorMessage});
}
