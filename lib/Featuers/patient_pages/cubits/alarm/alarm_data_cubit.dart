import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:health_care/Featuers/patient_pages/data/model/alarm_info.module.dart';
import 'package:health_care/Featuers/patient_pages/data/services/local_notification.service.dart';

part 'alarm_data_state.dart';

class AlarmDataCubit extends Cubit<AlarmDataState> {
  AlarmDataCubit() : super(AlarmDataInitial());

  List<AlarmInfo> alarmInfo = [];
  void addAlarm({required AlarmInfo alarm}) {
    emit(AlarmDataLoading());
    try {
      alarmInfo.add(alarm);
      Notifications().scheduleNotification(alarmInfo: alarm);
      emit(AlarmDataSuccesful());
    } catch (e) {
      emit(AlarmDataFailuer(errorMessage: e.toString()));
    }
  }

  void deleteAlarm({required AlarmInfo alarm}) {
    emit(AlarmDataLoading());
    try {
      alarmInfo.remove(alarm);
      Notifications().cancelNotification(alarmInfo: alarm);
      emit(AlarmDataSuccesful());
    } catch (e) {
      emit(AlarmDataFailuer(errorMessage: e.toString()));
    }
  }

  void toggleUpdateAlarmActivity({required AlarmInfo alarm}) {
    emit(AlarmDataLoading());
    try {
      alarm.isActive = !alarm.isActive;

      // Update the notification based on the new activity status
      if (alarm.isActive) {
        Notifications().scheduleNotification(alarmInfo: alarm);
      } else {
        Notifications().cancelNotification(alarmInfo: alarm);
      }

      emit(AlarmDataSuccesful());
    } catch (e) {
      emit(AlarmDataFailuer(errorMessage: e.toString()));
    }
  }
}
