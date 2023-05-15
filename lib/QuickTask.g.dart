// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuickTask.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuickTaskAdapter extends TypeAdapter<QuickTask> {
  @override
  final int typeId = 1;

  @override
  QuickTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuickTask(
      id: fields[0] as int?,
      taskNo: fields[1] as int?,
      tasktitle: fields[2] as String?,
      taskdetails: fields[3] as String?,
      taskcreatedAt: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, QuickTask obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.taskNo)
      ..writeByte(2)
      ..write(obj.tasktitle)
      ..writeByte(3)
      ..write(obj.taskdetails)
      ..writeByte(4)
      ..write(obj.taskcreatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuickTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
