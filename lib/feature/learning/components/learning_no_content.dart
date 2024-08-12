import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnquest/generated/l10n.dart';

class LearningNoContent extends StatefulWidget {
  const LearningNoContent({super.key});

  @override
  State<LearningNoContent> createState() => _LearningNoContentState();
}

class _LearningNoContentState extends State<LearningNoContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).no_lessons_saved),
            const SizedBox(height: 20),
            SvgPicture.asset(
              'assets/icons/no-content.svg',
              width: 200,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
