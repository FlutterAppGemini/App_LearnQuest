import 'package:dynamic_icons/dynamic_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnquest/common/models/course.dart';
import 'package:learnquest/common/models/lesson.dart';
import 'package:learnquest/common/models/lesson_arguments.dart';
import 'package:learnquest/feature/loading_overlay.dart';
import 'package:learnquest/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:learnquest/common/providers/course_provider.dart';
import 'package:learnquest/common/routes/routes.dart';
import 'package:learnquest/common/services/gemini_service.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isLoading = false;
  bool _isDatabase = false;
  bool _isBookmark = false;
  Course? course;
  bool hasLessons = false;

  Future<void> _saveBookmark(User user, Course course) async {
    _setLoading(true);
    try {
      setState(() {
        _isBookmark = true;
        _isDatabase = false;
      });
      final courseProvider =
          Provider.of<CourseProvider>(context, listen: false);
      int index = courseProvider.courses.indexOf(course);
      if (index != -1) {
        courseProvider.deleteCourse(index);
      }

      final courseData = course.toJson();
      final bookmarksRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('bookmarks');
      final courseDoc = bookmarksRef.doc(course.title);

      await courseDoc.set(courseData);
    } catch (e) {
      print(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _removeBookmark(User user, Course course) async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: S.of(context).unbookmark_course_title,
      text: S.of(context).unbookmark_course_text,
      confirmBtnText: S.of(context).yes_button,
      cancelBtnText: S.of(context).no_button,
      onCancelBtnTap: () {
        Navigator.of(context).pop();
      },
      onConfirmBtnTap: () async {
        _setLoading(true);
        try {
          setState(() {
            _isBookmark = false;
          });
          final bookmarksRef = FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('bookmarks');

          final courseDoc = bookmarksRef.doc(course.title);

          await courseDoc.delete();
        } catch (e) {
          print(e);
        } finally {
          _setLoading(false);
          Navigator.of(context).pop();
        }
      },
    );
  }

  void _deleteCourse(Course course) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: S.of(context).delete_course_title,
      text: S.of(context).delete_course_text,
      confirmBtnText: S.of(context).yes_button,
      cancelBtnText: S.of(context).no_button,
      onCancelBtnTap: () {
        Navigator.of(context).pop();
      },
      onConfirmBtnTap: () {
        final courseProvider =
            Provider.of<CourseProvider>(context, listen: false);

        int index = courseProvider.courses.indexOf(course);
        if (index != -1) {
          courseProvider.deleteCourse(index);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).course_deleted_message)),
          );

          Navigator.popAndPushNamed(context, Routes.home);
        }
      },
    );
  }

  void _continueWhereLeftOff(Course course) {
    Lesson incompleteLesson = course.lessons.firstWhere(
      (lesson) => lesson.progress < 1.0,
      orElse: () => course.lessons.last,
    );
    Navigator.pushNamed(
      context,
      Routes.lesson,
      arguments: LessonArguments(
        lesson: incompleteLesson,
        courseTitle: course.title,
        isBookmarked: _isBookmark,
        isDatabase: _isDatabase,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _setLoading(true);
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null && arguments is Course) {
        setState(() {
          course = arguments;
          hasLessons = course!.lessons.isNotEmpty;
        });
        await _checkIfInDatabaseOrFirebase(course!);
      }
      _setLoading(false);
    });
  }

  Future<void> _checkIfInDatabaseOrFirebase(Course course) async {
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    int index = courseProvider.courses.indexOf(course);
    if (index != -1) {
      setState(() {
        _isDatabase = true;
      });
    } else {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final bookmarksRef = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('bookmarks');
        final docSnapshot = await bookmarksRef.doc(course.title).get();
        if (docSnapshot.exists) {
          setState(() {
            _isBookmark = true;
          });
        }
      }
    }
  }

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (course != null) {
      setState(() {
        hasLessons = course!.lessons.isNotEmpty;
      });
    }
  }

  Future<void> newLesson(
      String courseTitle, List<Lesson> lesson, Course course) async {
    final lessonsIncomplete = course.totalLessons - course.completedLessons;
    if (lessonsIncomplete > 3) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        text: S.of(context).incomplete_lessons_alert_text(lessonsIncomplete),
      );
    } else {
      _setLoading(true);
      try {
        Lesson newLesson =
            await GeminiService.createLesson(courseTitle, lesson, context);
        final courseProvider =
            Provider.of<CourseProvider>(context, listen: false);

        int index = courseProvider.courses.indexOf(course);
        if (index != -1) {
          courseProvider.addLessonToCourse(index, newLesson);
        } else {
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            final bookmarksRef = FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .collection('bookmarks');

            course.lessons.add(newLesson);

            final updatedLessons =
                course.lessons.map((lesson) => lesson.toJson()).toList();

            await bookmarksRef.doc(course.title).update({
              'lessons': updatedLessons,
              'totalLessons': course.totalLessons++,
            });
          }
        }
      } catch (e) {
        print('Error new lesson: $e');
      } finally {
        _setLoading(false);
      }
    }
  }

  void _toggleBookmark(Course course) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Navigator.pushNamed(
        context,
        Routes.auth,
      );
    } else {
      if (_isBookmark) {
        await _removeBookmark(user, course);
      } else {
        await _saveBookmark(user, course);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (course == null) {
      return const LoadingOverlay(isLoading: true);
    }
    List<LessonTile> lessonTiles = course!.lessons.map((lesson) {
      return LessonTile(
        lesson: lesson,
        isBookmarked: _isBookmark,
        courseTitle: course!.title,
        isDatabase: _isDatabase,
      );
    }).toList();

    return Stack(children: [
      DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Container(
            color: Colors.deepPurpleAccent,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0)
                        .copyWith(top: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        _isDatabase
                            ? PopupMenuButton<int>(
                                icon: const Icon(Icons.more_vert,
                                    color: Colors.white),
                                onSelected: (item) =>
                                    onSelected(context, item, course!),
                                itemBuilder: (context) => [
                                  PopupMenuItem<int>(
                                    height: 25,
                                    value: 0,
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.delete,
                                          size: 16,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(S.of(context).delete_course),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          course!.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: course!.color.withOpacity(0.3),
                              radius: 30,
                              child: DynamicIcons.getIconFromName(course!.icon,
                                  color: course!.color, size: 40),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: Icon(
                                  _isBookmark
                                      ? Icons.bookmark
                                      : Icons.bookmark_border_outlined,
                                  color: Colors.yellow,
                                  size: 40),
                              onPressed: () => _toggleBookmark(course!),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      child: Column(
                        children: [
                          TabBar(
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: Colors.deepPurpleAccent,
                            indicatorWeight: 3.0,
                            tabs: [
                              Tab(text: S.of(context).description),
                              Tab(text: S.of(context).lessons),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                SingleChildScrollView(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        S.of(context).course_overview,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        course!.description,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        S.of(context).overall_progress,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      LinearProgressIndicator(
                                        value: course!.completedLessons /
                                            (course!.totalLessons == 0
                                                ? 1
                                                : course!.totalLessons),
                                        backgroundColor: Colors.grey[300],
                                        color: Colors.deepPurpleAccent,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "${(course!.completedLessons / (course!.totalLessons == 0 ? 1 : course!.totalLessons) * 100).toInt()}% ${S.of(context).course_completed(course!.completedLessons, course!.totalLessons)}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: hasLessons
                                            ? () =>
                                                _continueWhereLeftOff(course!)
                                            : null,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: hasLessons
                                              ? Colors.deepPurpleAccent
                                              : Colors.grey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: Text(
                                          S.of(context).continue_where_left_off,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SingleChildScrollView(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton.icon(
                                            onPressed: hasLessons
                                                ? () {
                                                    newLesson(
                                                        course!.title,
                                                        course!.lessons,
                                                        course!);
                                                  }
                                                : null,
                                            icon: const Icon(Icons.add,
                                                color: Colors.white),
                                            label: Text(
                                              S.of(context).generate_new_lesson,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: hasLessons
                                                  ? Colors.deepPurpleAccent
                                                  : Colors.grey,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      ...lessonTiles.map((lessonTile) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              Routes.lesson,
                                              arguments: LessonArguments(
                                                lesson: lessonTile.lesson,
                                                isBookmarked: _isBookmark,
                                                courseTitle: course!.title,
                                                isDatabase: _isDatabase,
                                              ),
                                            );
                                          },
                                          child: lessonTile,
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
      ),
      LoadingOverlay(isLoading: _isLoading),
    ]);
  }

  void onSelected(BuildContext context, int item, Course course) {
    switch (item) {
      case 0:
        _deleteCourse(course);
        break;
    }
  }
}

class LessonTile extends StatelessWidget {
  final Lesson lesson;
  final bool isBookmarked;
  final String courseTitle;
  final bool isDatabase;

  const LessonTile({
    super.key,
    required this.lesson,
    required this.isBookmarked,
    required this.isDatabase,
    required this.courseTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                lesson.progress == 1.0
                    ? Icons.check_circle
                    : Icons.play_circle_fill,
                color: lesson.progress == 1.0
                    ? Colors.green
                    : Colors.deepPurpleAccent,
                size: 32,
              ),
              title: Text(
                lesson.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.lesson,
                  arguments: LessonArguments(
                    lesson: lesson,
                    isBookmarked: isBookmarked,
                    courseTitle: courseTitle,
                    isDatabase: isDatabase,
                  ),
                );
              },
            ),
            LinearProgressIndicator(
              value: lesson.progress,
              backgroundColor: Colors.grey[200],
              color: Colors.deepPurpleAccent,
            ),
          ],
        ),
      ),
    );
  }
}
