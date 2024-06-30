import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'time_of_day_adapter.g.dart';

@HiveType(typeId: 1)
class TimeOfDayAdapter extends TypeAdapter<TimeOfDay> {
  @override
  final int typeId = 1;

  @override
  TimeOfDay read(BinaryReader reader) {
    final int hour = reader.readInt();
    final int minute = reader.readInt();
    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  void write(BinaryWriter writer, TimeOfDay obj) {
    writer.writeInt(obj.hour);
    writer.writeInt(obj.minute);
  }
}
