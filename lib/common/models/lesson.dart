import 'package:hive/hive.dart';
import 'package:learnquest/common/models/question.dart';

part 'lesson.g.dart';

@HiveType(typeId: 1)
class Lesson {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  double progress;

  @HiveField(3)
  List<Question> game;

  Lesson({
    required this.title,
    required this.content,
    required this.progress,
    required this.game,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      title: json['title'],
      content: json['content'],
      progress: json['progress'] == null ? 0.0 : json['progress'].toDouble(),
      game: (json['game'] as List<dynamic>)
          .map(
              (question) => Question.fromJson(question as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'progress': progress,
      'game': game.map((g) => g.toJson()).toList(),
    };
  }
}
