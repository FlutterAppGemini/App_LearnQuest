import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:learnquest/common/models/lesson.dart';
import 'package:learnquest/common/models/lesson_arguments.dart';
import 'package:learnquest/common/models/question.dart';
import 'package:learnquest/common/providers/course_provider.dart';
import 'package:learnquest/feature/chat/components/game_page.dart';
import 'package:learnquest/generated/l10n.dart';
import 'package:provider/provider.dart';

class GameFinished extends StatefulWidget {
  final List<Question> questions;
  final Map<int, dynamic> answers;
  final Lesson lesson;
  final String courseTitle;
  final bool isDatabase;
  final bool isBookmarked;

  const GameFinished({
    super.key,
    required this.questions,
    required this.answers,
    required this.lesson,
    required this.courseTitle,
    required this.isBookmarked,
    required this.isDatabase,
  });
  @override
  State<GameFinished> createState() => _GameFinishedState();
}

class _GameFinishedState extends State<GameFinished> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _updateLessonProgress();
    });
  }

  void _updateLessonProgress() async {
    if (widget.lesson.progress < 1.0) {
      widget.lesson.progress = 1.0;

      if (widget.isDatabase) {
        final courseProvider =
            Provider.of<CourseProvider>(context, listen: false);
        courseProvider.updateLessonProgress(widget.lesson);
      } else if (widget.isBookmarked) {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final bookmarksRef = FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('bookmarks');

          final courseDoc = bookmarksRef.doc(widget.courseTitle);
          final snapshot = await courseDoc.get();
          if (snapshot.exists) {
            final Map<String, dynamic> courseData =
                snapshot.data() as Map<String, dynamic>;
            List<dynamic> lessons = courseData['lessons'];

            for (var lessonData in lessons) {
              if (lessonData['title'] == widget.lesson.title) {
                lessonData['progress'] = widget.lesson.progress;
                break;
              }
            }
            final int completedLessons = courseData['completedLessons'] ?? 0;

            await courseDoc.update({
              'lessons': lessons,
              'completedLessons': completedLessons + 1,
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int correct = 0;
    widget.answers.forEach((index, value) {
      if (widget.questions[index].solution == value) correct++;
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            decoration: const BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                      context, Icons.replay, S.of(context).play_again_button,
                      () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GamePage(),
                        settings: RouteSettings(
                          arguments: LessonArguments(
                            courseTitle: widget.courseTitle,
                            lesson: widget.lesson,
                            isBookmarked: widget.isBookmarked,
                            isDatabase: widget.isDatabase,
                          ),
                        ),
                      ),
                    );
                  }),
                  _buildActionButton(context, Icons.arrow_back,
                      S.of(context).back_to_lesson_button, () {
                    Navigator.of(context).pop();
                  }),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 10,
                    ),
                  ],
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatisticsColumn(S.of(context).completion_label,
                            "100%", Colors.purple),
                        _buildStatisticsColumn(
                            S.of(context).total_question_label,
                            "${widget.questions.length}",
                            Colors.purple),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatisticsColumn(S.of(context).correct_label,
                            "$correct", Colors.green),
                        _buildStatisticsColumn(S.of(context).wrong_label,
                            "${widget.questions.length - correct}", Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildAnswersList(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnswersList() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.questions.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(widget.questions[index].question),
              subtitle: Text(
                '${S.of(context).correct_answer_prefix} ${widget.questions[index].solution}',
                style: const TextStyle(color: Colors.green),
              ),
              trailing: Icon(
                widget.answers[index] == widget.questions[index].solution
                    ? Icons.check_circle
                    : Icons.cancel,
                color: widget.answers[index] == widget.questions[index].solution
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }

  Column _buildStatisticsColumn(String title, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 5,
              backgroundColor: color,
            ),
            const SizedBox(width: 5),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label,
      VoidCallback onPressed) {
    return Column(
      children: [
        FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: onPressed,
          heroTag: label,
          child: Icon(icon, color: Colors.deepPurpleAccent),
        ),
        const SizedBox(height: 8.0),
        Text(label, style: const TextStyle(color: Colors.black)),
      ],
    );
  }
}
