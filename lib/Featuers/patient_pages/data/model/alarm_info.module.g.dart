// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_info.module.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlarmInfoAdapter extends TypeAdapter<AlarmInfo> {
  @override
  final int typeId = 0;

  @override
  AlarmInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlarmInfo(
      id: fields[0] as String,
      isActive: fields[4] as bool,
      title: fields[1] as String,
      alarmDateTime: fields[2] as TimeOfDay,
      description: fields[3] as String,
      interval: fields[5] as int,
      email: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AlarmInfo obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.alarmDateTime)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.isActive)
      ..writeByte(5)
      ..write(obj.interval)
      ..writeByte(6)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlarmInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
