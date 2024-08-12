import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learnquest/common/models/course.dart';
import 'package:learnquest/common/models/lesson.dart';
import 'package:learnquest/common/models/question.dart';
import 'package:path_provider/path_provider.dart' as path;

class CourseProvider extends ChangeNotifier {
  late Box<Course> _courseBox;

  static Future<void> initHive() async {
    final dir = await path.getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    await Hive.initFlutter('learnquest.db');

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CourseAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(LessonAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(QuestionAdapter());
    }

    await Hive.openBox<Course>('course_box');
  }

  CourseProvider() {
    _courseBox = Hive.box<Course>('course_box');
  }

  List<Course> get courses => _courseBox.values.toList();

  void addCourse(Course course) {
    _courseBox.add(course);
    notifyListeners();
  }

  void updateCourse(int index, Course course) {
    _courseBox.putAt(index, course);
    notifyListeners();
  }

  void deleteCourse(int index) {
    _courseBox.deleteAt(index);
    notifyListeners();
  }

  void addLessonToCourse(int courseIndex, Lesson lesson) {
    final course = _courseBox.getAt(courseIndex);
    if (course != null) {
      course.lessons.add(lesson);
      course.totalLessons++;
      updateCourse(courseIndex, course);
    }
  }

  void updateLessonProgress(Lesson lesson) {
    int courseIndex = _courseBox.values
        .toList()
        .indexWhere((course) => course.lessons.contains(lesson));
    if (courseIndex != -1) {
      final course = _courseBox.getAt(courseIndex);
      if (course != null) {
        int lessonIndex = course.lessons.indexOf(lesson);
        if (lessonIndex != -1) {
          course.lessons[lessonIndex].progress = lesson.progress;
          if (lesson.progress == 1.0) {
            course.completedLessons++;
          }
          updateCourse(courseIndex, course);
        }
      }
    }
  }
}
