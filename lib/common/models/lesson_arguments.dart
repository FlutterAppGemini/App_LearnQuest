import 'package:learnquest/common/models/lesson.dart';

class LessonArguments {
  final Lesson lesson;
  final String courseTitle;
  final bool isBookmarked;
  final bool isDatabase;

  LessonArguments({
    required this.lesson,
    required this.isBookmarked,
    required this.isDatabase,
    required this.courseTitle,
  });
}
