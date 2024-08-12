import 'dart:convert';
import 'dart:io';

import 'package:dynamic_icons/dynamic_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:learnquest/common/models/course.dart';
import 'package:learnquest/generated/l10n.dart';

import '../models/lesson.dart';

class GeminiService {
  static late GenerativeModel model;
  static late String _modelName;
  static late String _apiKey;
  static late List<SafetySetting> _safetySettings;
  static late GenerationConfig _generationConfig;

  static Future<void> load(String systemInstruction) async {
    _apiKey = dotenv.env['GEMINI_API'].toString();
    _modelName = 'gemini-1.5-flash';
    _safetySettings = [
      SafetySetting(HarmCategory.harassment, HarmBlockThreshold.medium),
      SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.medium),
      SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.medium),
      SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.medium),
    ];
    if (_apiKey == '') {
      stderr.writeln(r'No $GEMINI_API environment variable');
      exit(1);
    }
    _generationConfig = GenerationConfig(
      temperature: 1,
      topK: 64,
      topP: 0.95,
      maxOutputTokens: 8192,
      responseMimeType: 'application/json',
    );
    model = GenerativeModel(
      model: _modelName,
      apiKey: _apiKey,
      safetySettings: _safetySettings,
      generationConfig: _generationConfig,
      systemInstruction: Content.system(systemInstruction),
    );
  }

  static Future<void> updateSystemInstruction(String systemInstruction) async {
    model = GenerativeModel(
      model: _modelName,
      apiKey: _apiKey,
      safetySettings: _safetySettings,
      generationConfig: _generationConfig,
      systemInstruction: Content.system(systemInstruction),
    );
  }

  static Future<Course> createCourse(
      String prompt, BuildContext context) async {
    bool hasError;
    Course? course;
    String iconList = jsonEncode(DynamicIcons.iconList.keys.toList());
    do {
      try {
        final content = [
          Content.text(
              S.of(context).gemini_create_course_prompt(prompt, iconList)),
        ];

        final response = await GeminiService.model.generateContent(content);
        print(response.text);

        final Map<String, dynamic> map = jsonDecode(response.text ?? '');
        map['totalLessons'] = 1;
        map['completedLessons'] = 0;

        course = Course.fromJson(map);
        hasError = false;
      } on FormatException {
        hasError = true;
      }
    } while (hasError);

    return course!;
  }

  static Future<Lesson> createLesson(String courseTitle,
      List<Lesson> previousLessons, BuildContext context) async {
    bool hasError;
    Lesson? newLesson;

    do {
      try {
        final lastLessons = previousLessons.length > 3
            ? previousLessons.sublist(previousLessons.length - 3)
            : previousLessons;
        final summaryLessons = lastLessons.map((lesson) {
          return {
            'title': lesson.title,
            'content': lesson.content,
          };
        }).toList();
        final summary = jsonEncode(summaryLessons);

        final content = [
          Content.text(
              S.of(context).gemini_create_lesson_prompt(courseTitle, summary)),
        ];

        final response = await GeminiService.model.generateContent(content);

        print(response.text);
        final Map<String, dynamic> map = jsonDecode(response.text ?? '');
        map['progress'] = 0.0;

        newLesson = Lesson.fromJson(map);
        hasError = false;
      } catch (e) {
        hasError = true;
      }
    } while (hasError);

    return newLesson!;
  }

  static Future<bool> isInappropiate(String topic, BuildContext context) async {
    bool hasError;
    do {
      try {
        final content = [
          Content.text(S.of(context).gemini_is_inappropriate_prompt(topic)),
        ];

        final response = await GeminiService.model.generateContent(content);
        print(response.text);
        final Map<String, dynamic> map = jsonDecode(response.text ?? '');
        return map['value'] == null ? false : map['value'] as bool;
      } on FormatException {
        hasError = true;
      }
    } while (hasError);
  }
}
