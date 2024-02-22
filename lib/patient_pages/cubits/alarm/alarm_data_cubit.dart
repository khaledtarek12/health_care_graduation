import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:health_care/patient_pages/data/model/alarm_info.module.dart';

part 'alarm_data_state.dart';

class AlarmDataCubit extends Cubit<AlarmDataState> {
  AlarmDataCubit() : super(AlarmDataInitial());

  List<AlarmInfo> alarmInfo = [];
  void addAlarm({required AlarmInfo alarm}) {
    emit(AlarmDataLoading());
    try {
      alarmInfo.add(alarm);

      emit(AlarmDataSuccesful());
    } catch (e) {
      emit(AlarmDataFailuer(errorMessage: e.toString()));
    }
  }

  void deleteAlarm({required AlarmInfo alarm}) {
    emit(AlarmDataLoading());
    try {
      alarmInfo.remove(alarm);
      emit(AlarmDataSuccesful());
    } catch (e) {
      emit(AlarmDataFailuer(errorMessage: e.toString()));
    }
  }
}
