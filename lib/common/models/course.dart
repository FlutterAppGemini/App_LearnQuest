import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'lesson.dart';

part 'course.g.dart';

@HiveType(typeId: 0)
class Course {
  @HiveField(0)
  String title;

  @HiveField(1)
  String icon;

  @HiveField(2)
  int colorValue;

  @HiveField(3)
  String description;

  @HiveField(4)
  int totalLessons;

  @HiveField(5)
  int completedLessons;

  @HiveField(7)
  List<Lesson> lessons;

  Course({
    required this.title,
    required this.icon,
    required Color color,
    required this.description,
    required this.totalLessons,
    required this.completedLessons,
    List<Lesson>? lessons,
  })  : lessons = lessons ?? [],
        colorValue = color.value;

  Color get color => Color(colorValue);

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json['title'],
      icon: json['icon'],
      color: Color(int.parse(json['color'], radix: 16) + 0xFF000000),
      description: json['description'],
      totalLessons: (json['lessons'] as List<dynamic>)
          .map((lesson) => Lesson.fromJson(lesson as Map<String, dynamic>))
          .toList().length,
      completedLessons: json['completedLessons'],
      lessons: (json['lessons'] as List<dynamic>)
              .map((lesson) => Lesson.fromJson(lesson as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'icon': icon,
      'color': color.value.toRadixString(16),
      'description': description,
      'totalLessons': totalLessons,
      'completedLessons': completedLessons,
      'lessons': lessons.map((lesson) => lesson.toJson()).toList(),
    };
  }
}
