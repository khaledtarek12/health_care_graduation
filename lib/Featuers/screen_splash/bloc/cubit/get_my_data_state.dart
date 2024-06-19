part of 'get_my_data_cubit.dart';

@immutable
sealed class GetMyDataState {}

final class GetMyDataInitial extends GetMyDataState {}

final class GetMyDataLoading extends GetMyDataState {}

final class GetMyDataSuccess extends GetMyDataState {}

final class GetMyDataFailure extends GetMyDataState {
  final String errorMessage;

  GetMyDataFailure({required this.errorMessage});
}
