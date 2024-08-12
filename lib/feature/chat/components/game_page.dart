import 'package:flutter/material.dart';
import 'package:learnquest/common/models/lesson.dart';
import 'package:learnquest/common/models/lesson_arguments.dart';
import 'package:learnquest/common/models/question.dart';
import 'package:learnquest/feature/chat/components/game_finished.dart';
import 'package:learnquest/generated/l10n.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int _currentIndex = 0;
  final Map<int, dynamic> _answers = {};

  late Lesson lesson;
  late String courseTitle;
  late bool isBookmarked;
  late bool isDatabase;
  late List<Question> game;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final LessonArguments arguments =
        ModalRoute.of(context)!.settings.arguments as LessonArguments;

    lesson = arguments.lesson;
    isBookmarked = arguments.isBookmarked;
    isDatabase = arguments.isDatabase;
    courseTitle = arguments.courseTitle;
    game = arguments.lesson.game;
  }

  @override
  Widget build(BuildContext context) {
    Question question = game[_currentIndex];
    final List<dynamic> options = question.response;

    void nextSubmit() {
      if (_answers[_currentIndex] == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(S.of(context).select_answer_warning),
        ));
        return;
      }
      if (_currentIndex < (game.length - 1)) {
        setState(() {
          _currentIndex++;
        });
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => GameFinished(
              questions: game,
              answers: _answers,
              lesson: lesson,
              isDatabase: isDatabase,
              isBookmarked: isBookmarked,
              courseTitle: courseTitle,
            ),
          ),
        );
      }
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text(
            S.of(context).quiz_title,
            style: const TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          elevation: 0,
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: LinearProgressIndicator(
                      value: (_currentIndex + 1) / game.length,
                      backgroundColor: const Color.fromARGB(255, 157, 105, 201),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(255, 212, 175, 255)),
                      minHeight: 10.0,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 1,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.purple.shade50,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            children: [
                              Text(
                                S.of(context).question_progress(
                                    _currentIndex + 1, game.length),
                                style: const TextStyle(
                                    color: Colors.deepPurpleAccent,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                game[_currentIndex].question,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 66, 66, 66),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Expanded(
                          child: ListView.builder(
                            itemCount: options.length,
                            itemBuilder: (context, indexOption) {
                              final option = options[indexOption];
                              return _buildOptionTile(
                                  option, _answers[_currentIndex] == option);
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurpleAccent,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32.0, vertical: 12.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: _currentIndex == 0
                                  ? null
                                  : () {
                                      setState(() {
                                        _currentIndex--;
                                      });
                                    },
                              child: Text(
                                S.of(context).previous_button,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurpleAccent,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32.0, vertical: 12.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: nextSubmit,
                              child: Text(
                                _currentIndex == (game.length - 1)
                                    ? S.of(context).submit_button
                                    : S.of(context).next_button,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTile(String option, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _answers[_currentIndex] = option;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 171, 112, 240)
              : Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: isSelected
                ? const Color.fromARGB(255, 171, 112, 240)
                : Colors.transparent,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Text(
            option,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog<bool>(
            context: context,
            builder: (_) {
              return AlertDialog(
                content: Text(S.of(context).quit_quiz_warning_message),
                title: Text(S.of(context).quit_quiz_warning_title),
                actions: <Widget>[
                  TextButton(
                    child: Text(S.of(context).yes_button),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                  TextButton(
                    child: Text(S.of(context).no_button),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                ],
              );
            })) ??
        false;
  }
}
