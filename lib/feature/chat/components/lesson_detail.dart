import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:learnquest/common/models/lesson.dart';
import 'package:learnquest/common/models/lesson_arguments.dart';
import 'package:learnquest/common/providers/course_provider.dart';
import 'package:learnquest/common/routes/routes.dart';
import 'package:learnquest/generated/l10n.dart';
import 'package:provider/provider.dart';

class LessonDetail extends StatefulWidget {
  const LessonDetail({super.key});

  @override
  State<LessonDetail> createState() => _LessonDetailState();
}

class _LessonDetailState extends State<LessonDetail>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  double _progress = 0;
  double _secondaryProgress = 0;
  bool _isLessonCompleted = false;
  late AnimationController _animationController;

  late Lesson lesson;
  late String courseTitle;
  late bool isBookmarked;
  late bool isDatabase;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_updateProgress);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateInitialProgress();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final LessonArguments arguments =
        ModalRoute.of(context)!.settings.arguments as LessonArguments;

    lesson = arguments.lesson;
    isBookmarked = arguments.isBookmarked;
    isDatabase = arguments.isDatabase;
    courseTitle = arguments.courseTitle;

    _secondaryProgress = lesson.progress;
    _isLessonCompleted = _secondaryProgress >= 0.8;
  }

  void _updateProgress() {
    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final newProgress = (currentScroll / maxScrollExtent).clamp(0, 1);

    setState(() {
      _progress = newProgress as double;
      if (_progress == 1) {
        _animationController.forward();
      } else {
        _animationController.reset();
      }
    });
  }

  void _calculateInitialProgress() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;

        if (maxScrollExtent > 0) {
          setState(() {
            _progress = 0;
            _animationController.reset();
          });
        } else {
          setState(() {
            _progress = 1.0;
            _animationController.forward();
          });
        }
      }
    });
  }

  void _completeLesson() {
    if (_secondaryProgress >= 1.0) {
      return;
    }
    setState(() {
      _isLessonCompleted = true;
      _secondaryProgress = 0.8;
    });
    _updateLessonProgress();
  }

  void _updateLessonInFirebase() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final bookmarksRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('bookmarks');

      final courseDoc = bookmarksRef.doc(courseTitle);
      final snapshot = await courseDoc.get();
      if (snapshot.exists) {
        final Map<String, dynamic> courseData =
            snapshot.data() as Map<String, dynamic>;
        List<dynamic> lessons = courseData['lessons'];

        for (var lessonData in lessons) {
          if (lessonData['title'] == lesson.title) {
            lessonData['progress'] = lesson.progress;
            break;
          }
        }

        await courseDoc.update({'lessons': lessons});
      }
    }
  }

  void _updateLessonProgress() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        lesson.progress = _secondaryProgress;
        if (isDatabase) {
          final courseProvider =
              Provider.of<CourseProvider>(context, listen: false);
          courseProvider.updateLessonProgress(lesson);
        } else if (isBookmarked) {
          _updateLessonInFirebase();
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateProgress);
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.deepPurpleAccent,
        leading: IconButton(
          icon: Icon(
            Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.play_circle_filled),
            label: Text(S.of(context).start_game_label),
            onPressed: _isLessonCompleted
                ? () {
                    Navigator.pushNamed(
                      context,
                      Routes.game,
                      arguments: LessonArguments(
                          lesson: lesson,
                          isBookmarked: isBookmarked,
                          isDatabase: isDatabase,
                          courseTitle: courseTitle),
                    );
                  }
                : null,
            style: TextButton.styleFrom(
              foregroundColor: _isLessonCompleted
                  ? Colors.purpleAccent
                  : Colors.purple.shade200,
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: ScaleTransition(
            scale: _animationController.drive(
              Tween(begin: 1.0, end: 1.5)
                  .chain(CurveTween(curve: Curves.elasticOut)),
            ),
            child: LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.purple.shade200.withOpacity(0.3),
              color: Colors.purpleAccent,
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20.0),
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ListView(
                  controller: _scrollController,
                  children: <Widget>[
                    Text(
                      lesson.title,
                      style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepPurpleAccent),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: _secondaryProgress,
                            backgroundColor: Colors.grey[300],
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Text("${(_secondaryProgress * 100).toInt()}%"),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    MarkdownBody(
                      selectable: true,
                      data: lesson.content,
                      styleSheet: MarkdownStyleSheet(
                        p: const TextStyle(
                          fontSize: 16.0,
                          height: 1.5,
                          color: Colors.black87,
                        ),
                        h1: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        h2: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                        h3: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        listBullet: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black87,
                        ),
                        blockSpacing: 10.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: _progress == 1.0 ? () => _completeLesson() : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _progress == 1.0
                    ? Colors.purpleAccent
                    : Colors.purple.shade200,
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                S.of(context).complete_lesson_text,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
