import 'package:dynamic_icons/dynamic_icons.dart';
import 'package:flutter/material.dart';
import 'package:learnquest/common/models/course.dart';
import 'package:learnquest/common/routes/routes.dart';
import 'package:learnquest/generated/l10n.dart';

class LearningPageContent extends StatefulWidget {
  final List<Course> courses;
  const LearningPageContent({super.key, required this.courses});

  @override
  State<LearningPageContent> createState() => _LearningPageContentState();
}

class _LearningPageContentState extends State<LearningPageContent> {
  Widget _buildCourseCard(String icon, String label, Color color,
      double progress, int totalLesson) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
            backgroundColor: color.withOpacity(0.3),
            child: DynamicIcons.getIconFromName(
              icon.toLowerCase(),
              color: color,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 4),
                Text(
                  S.of(context).total_lessons(totalLesson),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[200],
                  color: color,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Icon(Icons.play_arrow, color: color),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                color: Colors.deepPurpleAccent,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatisticCard(
                            Icons.library_books,
                            S.of(context).statistic_courses,
                            "${widget.courses.length}"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(top: 0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 3.5,
              ),
              itemCount: widget.courses.length,
              itemBuilder: (context, index) {
                final course = widget.courses[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.detail,
                      arguments: course,
                    );
                  },
                  child: _buildCourseCard(
                      course.icon,
                      course.title,
                      course.color,
                      course.completedLessons /
                          (course.totalLessons == 0 ? 1 : course.totalLessons),
                      course.totalLessons),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticCard(IconData icon, String label, String count) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.2),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        Text(
          count,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
