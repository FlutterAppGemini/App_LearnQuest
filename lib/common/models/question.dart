import 'package:hive/hive.dart';

part 'question.g.dart';

@HiveType(typeId: 3)
class Question {
  @HiveField(0)
  String question;

  @HiveField(1)
  List<String> response;

  @HiveField(2)
  String solution;

  Question({
    required this.question,
    required this.response,
    required this.solution,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      response: List<String>.from(json['response']),
      solution: json['solution'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'response': response,
      'solution': solution,
    };
  }
}
