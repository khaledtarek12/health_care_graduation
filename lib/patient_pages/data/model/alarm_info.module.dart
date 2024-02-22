import 'package:flutter/material.dart';

class AlarmInfo {
  String title;
  TimeOfDay alarmDateTime;
  String description;
  // bool isActive = true;

  AlarmInfo({
    required this.title,
    required this.alarmDateTime,
    required this.description,
  });
}
