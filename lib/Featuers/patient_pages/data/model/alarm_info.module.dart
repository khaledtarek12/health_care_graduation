import 'package:flutter/material.dart';

class AlarmInfo {
  String id;
  String title;
  TimeOfDay alarmDateTime;
  String description;
  bool isActive;
  int interval;

  AlarmInfo({
    required this.id,
    required this.isActive,
    required this.title,
    required this.alarmDateTime,
    required this.description,
    required this.interval,
  });
}
