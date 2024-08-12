import 'package:dynamic_icons/dynamic_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:learnquest/common/models/course.dart';
import 'package:learnquest/common/providers/course_provider.dart';
import 'package:learnquest/common/routes/routes.dart';
import 'package:learnquest/generated/l10n.dart';
import 'package:learnquest/common/services/gemini_service.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ChatPage extends StatefulWidget {
  final Function(bool) setLoading;
  const ChatPage({super.key, required this.setLoading});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _createCourse(String value) async {
    widget.setLoading(true);
    try {
      final isInappropriate =
          await GeminiService.isInappropiate(value, context);
      if (!isInappropriate) {
        Course course = await GeminiService.createCourse(value, context);
        Provider.of<CourseProvider>(context, listen: false).addCourse(course);
      } else {
        widget.setLoading(false);
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: S.of(context).create_course_inappropriate_error,
        );
      }
    } on GenerativeAIException {
      widget.setLoading(false);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: S.of(context).create_course_inappropriate_warning,
      );
    } finally {
      widget.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final courses = Provider.of<CourseProvider>(context).courses;
    createTile(Course course) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.detail,
                arguments: course,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: course.color.withOpacity(0.3),
                    child: DynamicIcons.getIconFromName(course.icon,
                        color: course.color, size: 30),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title,
                          style: TextStyle(
                            color: course.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          S.of(context).total_lessons(course.totalLessons),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: course.completedLessons /
                              (course.totalLessons == 0
                                  ? 1
                                  : course.totalLessons),
                          backgroundColor: Colors.grey[200],
                          color: course.color,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.play_arrow, color: course.color),
                ],
              ),
            ),
          ),
        );

    final coursesDisplayed = ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return createTile(courses[index]);
      },
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
          ),
          Column(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        S.of(context).welcome_text,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "LearnQuest",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: _controller,
                        textInputAction: TextInputAction.send,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 20.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: S.of(context).enter_topic_hint,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.send,
                                color: Color.fromARGB(255, 1, 82, 173)),
                            onPressed: () {
                              _createCourse(_controller.text);
                              _controller.clear();
                            },
                          ),
                        ),
                        onSubmitted: (value) {
                          _createCourse(value);
                          _controller.clear();
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Text(
                      S.of(context).your_courses,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: coursesDisplayed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
