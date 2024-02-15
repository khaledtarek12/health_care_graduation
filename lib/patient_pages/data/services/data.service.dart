import 'package:health_care/patient_pages/data/model/alarm_info.module.dart';

List<AlarmInfo> alarms = [
  AlarmInfo(
      alarmDateTime: DateTime.now().add(const Duration(hours: 1)),
      description: 'Office',
      isActive: false),
  AlarmInfo(
      alarmDateTime: DateTime.now().add(const Duration(hours: 1)),
      description: 'Doctor',
      isActive: false),
];
