import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:health_care/Featuers/patient_pages/data/model/alarm_info.module.dart';
import 'package:health_care/Featuers/patient_pages/data/services/notification_awsome.service.dart';
import 'package:health_care/const.dart';
import 'package:hive/hive.dart';

part 'alarm_data_state.dart';

class AlarmDataCubit extends Cubit<AlarmDataState> {
  AlarmDataCubit() : super(AlarmDataInitial());

  List<AlarmInfo> alarmInfo = [];
  void addAlarm({required AlarmInfo alarm}) async {
    emit(AlarmDataLoading());
    try {
      var alarmBox = Hive.box<AlarmInfo>(kAlarmbox);
      alarmInfo.add(alarm);
      await alarmBox.add(alarm);
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
      alarm.delete;
      alarm.save;
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
        alarm.save();
      } else {
        Notifications().cancelNotification(alarmInfo: alarm);
        alarm.save();
      }

      emit(AlarmDataSuccesful());
    } catch (e) {
      emit(AlarmDataFailuer(errorMessage: e.toString()));
    }
  }

  void fetchAllAlarms({required String email}) async {
    emit(AlarmDataLoading());
    try {
      var alarmBox = Hive.box<AlarmInfo>(kAlarmbox);
      alarmInfo =
          alarmBox.values.where((alarm) => alarm.email == email).toList();
      emit(AlarmDataSuccesful());
    } catch (e) {
      emit(AlarmDataFailuer(errorMessage: e.toString()));
    }
  }

  void closeBox() async {
    emit(AlarmDataLoading());
    try {
      var alarmBox = Hive.box<AlarmInfo>(kAlarmbox);
      alarmBox.close();
      emit(AlarmDataSuccesful());
    } catch (e) {
      emit(AlarmDataFailuer(errorMessage: e.toString()));
    }
  }
}
