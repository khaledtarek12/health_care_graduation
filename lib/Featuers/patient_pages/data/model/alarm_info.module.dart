import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'alarm_info.module.g.dart';

@HiveType(typeId: 0)
class AlarmInfo extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  TimeOfDay alarmDateTime;
  @HiveField(3)
  String description;
  @HiveField(4)
  bool isActive;
  @HiveField(5)
  int interval;
  @HiveField(6)
  String email;

  AlarmInfo({
    required this.id,
    required this.isActive,
    required this.title,
    required this.alarmDateTime,
    required this.description,
    required this.interval,
    required this.email,
  });
}
