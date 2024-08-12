// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseAdapter extends TypeAdapter<Course> {
  @override
  final int typeId = 0;

  @override
  Course read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Course(
      title: fields[0] as String,
      icon: fields[1] as String,
      color: Color(fields[2] as int),
      description: fields[3] as String,
      totalLessons: fields[4] as int,
      completedLessons: fields[5] as int,
      lessons: (fields[7] as List?)?.cast<Lesson>(),
    )..colorValue = fields[2] as int;
  }

  @override
  void write(BinaryWriter writer, Course obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.icon)
      ..writeByte(2)
      ..write(obj.colorValue)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.totalLessons)
      ..writeByte(5)
      ..write(obj.completedLessons)
      ..writeByte(7)
      ..write(obj.lessons);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
