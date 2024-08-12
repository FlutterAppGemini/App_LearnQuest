// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Generate a course on the topic '{topic}'. Expected structure for a new course:\n{ \n    "title": "title", \n    "icon": "icon from the list: {iconList}", \n    "color": "A string representing a color in hexadecimal format (without the hash sign)", \n    "description": "Brief description of the subject or what will be covered", \n    "lessons": [ \n        { \n            "title": "Lesson title", \n            "content": "Detailed lesson content, provided in a clear and example-driven manner", \n            "game": [ \n                { \n                    "question": "Question 1", \n                    "response": [ \n                        "Answer 1", \n                        "Answer 2", \n                        "Answer 3", \n                        "Answer 4", \n                        "Answer 5" \n                    ], \n                    "solution": "Answer 1" \n                } \n            ] \n        } \n    ] \n} \n Expected structure for a lesson continuation: \n{ \n    "title": "Title of the next lesson", \n    "content": "Detailed content for the entire lesson, with clear examples", \n    "progress": 0.0, \n    "game": [ \n        { \n            "question": "Question 1", \n            "response": [ \n                "Answer 1", \n                "Answer 2", \n                "Answer 3", \n                "Answer 4", \n                "Answer 5" \n            ], \n            "solution": "Answer 1" \n        } \n    ] \n}`
  String gemini_create_course_prompt(Object topic, Object iconList) {
    return Intl.message(
      'Generate a course on the topic \'$topic\'. Expected structure for a new course:\n{ \n    "title": "title", \n    "icon": "icon from the list: $iconList", \n    "color": "A string representing a color in hexadecimal format (without the hash sign)", \n    "description": "Brief description of the subject or what will be covered", \n    "lessons": [ \n        { \n            "title": "Lesson title", \n            "content": "Detailed lesson content, provided in a clear and example-driven manner", \n            "game": [ \n                { \n                    "question": "Question 1", \n                    "response": [ \n                        "Answer 1", \n                        "Answer 2", \n                        "Answer 3", \n                        "Answer 4", \n                        "Answer 5" \n                    ], \n                    "solution": "Answer 1" \n                } \n            ] \n        } \n    ] \n} \n Expected structure for a lesson continuation: \n{ \n    "title": "Title of the next lesson", \n    "content": "Detailed content for the entire lesson, with clear examples", \n    "progress": 0.0, \n    "game": [ \n        { \n            "question": "Question 1", \n            "response": [ \n                "Answer 1", \n                "Answer 2", \n                "Answer 3", \n                "Answer 4", \n                "Answer 5" \n            ], \n            "solution": "Answer 1" \n        } \n    ] \n}',
      name: 'gemini_create_course_prompt',
      desc: '',
      args: [topic, iconList],
    );
  }

  /// `Expected structure for a new course: \n{ \n    "title": "title", \n    "icon": "icon from the list: {iconList}", \n    "color": "A string representing a color in hexadecimal format (without the hash sign)", \n    "description": "Brief description of the subject or what will be covered", \n    "lessons": [ \n        { \n            "title": "Lesson title", \n            "content": "Detailed lesson content, provided in a clear and example-driven manner", \n            "game": [ \n                { \n                    "question": "Question 1", \n                    "response": [ \n                        "Answer 1", \n                        "Answer 2", \n                        "Answer 3", \n                        "Answer 4", \n                        "Answer 5" \n                    ], \n                    "solution": "Answer 1" \n                } \n            ] \n        } \n    ] \n} \n Expected structure for a lesson continuation: \n{ \n    "title": "Title of the next lesson", \n    "content": "Detailed content for the entire lesson, with clear examples", \n    "progress": 0.0, \n    "game": [ \n        { \n            "question": "Question 1", \n            "response": [ \n                "Answer 1", \n                "Answer 2", \n                "Answer 3", \n                "Answer 4", \n                "Answer 5" \n            ], \n            "solution": "Answer 1" \n        } \n    ] \n} \n\n1. When requesting an initial course on a topic, the response should follow the first structure.\n2. When requesting a continuation of a lesson on a topic, the response should follow the second structure.\n3. "game" is an array of questions (between 5 and 8).\n4. "response" is an array of answers (between 4 and 7), where one is correct and should be specified as a string in "solution".\n5. When requesting a new lesson for a previously given topic, the content should advance incrementally, avoiding repetition of previous lessons, and keeping the content clear and well-explained.\n6. Do not include images or links.`
  String gemini_system_instruction(Object iconList) {
    return Intl.message(
      'Expected structure for a new course: \n{ \n    "title": "title", \n    "icon": "icon from the list: $iconList", \n    "color": "A string representing a color in hexadecimal format (without the hash sign)", \n    "description": "Brief description of the subject or what will be covered", \n    "lessons": [ \n        { \n            "title": "Lesson title", \n            "content": "Detailed lesson content, provided in a clear and example-driven manner", \n            "game": [ \n                { \n                    "question": "Question 1", \n                    "response": [ \n                        "Answer 1", \n                        "Answer 2", \n                        "Answer 3", \n                        "Answer 4", \n                        "Answer 5" \n                    ], \n                    "solution": "Answer 1" \n                } \n            ] \n        } \n    ] \n} \n Expected structure for a lesson continuation: \n{ \n    "title": "Title of the next lesson", \n    "content": "Detailed content for the entire lesson, with clear examples", \n    "progress": 0.0, \n    "game": [ \n        { \n            "question": "Question 1", \n            "response": [ \n                "Answer 1", \n                "Answer 2", \n                "Answer 3", \n                "Answer 4", \n                "Answer 5" \n            ], \n            "solution": "Answer 1" \n        } \n    ] \n} \n\n1. When requesting an initial course on a topic, the response should follow the first structure.\n2. When requesting a continuation of a lesson on a topic, the response should follow the second structure.\n3. "game" is an array of questions (between 5 and 8).\n4. "response" is an array of answers (between 4 and 7), where one is correct and should be specified as a string in "solution".\n5. When requesting a new lesson for a previously given topic, the content should advance incrementally, avoiding repetition of previous lessons, and keeping the content clear and well-explained.\n6. Do not include images or links.',
      name: 'gemini_system_instruction',
      desc: '',
      args: [iconList],
    );
  }

  /// `Generate a new lesson for the course '{courseTitle}'. Here is a summary of the last lessons:\n{summary}\nContinue the course with a new lesson related to these topics.Expected structure for a lesson continuation: \n{ \n    "title": "Title of the next lesson", \n    "content": "Detailed content for the entire lesson, with clear examples", \n    "progress": 0.0, \n    "game": [ \n        { \n            "question": "Question 1", \n            "response": [ \n                "Answer 1", \n                "Answer 2", \n                "Answer 3", \n                "Answer 4", \n                "Answer 5" \n            ], \n            "solution": "Answer 1" \n        } \n    ] \n} `
  String gemini_create_lesson_prompt(Object courseTitle, Object summary) {
    return Intl.message(
      'Generate a new lesson for the course \'$courseTitle\'. Here is a summary of the last lessons:\n$summary\nContinue the course with a new lesson related to these topics.Expected structure for a lesson continuation: \n{ \n    "title": "Title of the next lesson", \n    "content": "Detailed content for the entire lesson, with clear examples", \n    "progress": 0.0, \n    "game": [ \n        { \n            "question": "Question 1", \n            "response": [ \n                "Answer 1", \n                "Answer 2", \n                "Answer 3", \n                "Answer 4", \n                "Answer 5" \n            ], \n            "solution": "Answer 1" \n        } \n    ] \n} ',
      name: 'gemini_create_lesson_prompt',
      desc: '',
      args: [courseTitle, summary],
    );
  }

  /// `Is the topic '{topic}' inappropriate according to GeminiAIs standards? the response should follow this JSON format: \n{ \n    "reason": "Explanation of why the topic is inappropriate or if it is not", \n    "value": "true or false (this is a boolean)" \n}`
  String gemini_is_inappropriate_prompt(Object topic) {
    return Intl.message(
      'Is the topic \'$topic\' inappropriate according to GeminiAIs standards? the response should follow this JSON format: \n{ \n    "reason": "Explanation of why the topic is inappropriate or if it is not", \n    "value": "true or false (this is a boolean)" \n}',
      name: 'gemini_is_inappropriate_prompt',
      desc: '',
      args: [topic],
    );
  }

  /// `The topic you want to learn is inappropriate`
  String get create_course_inappropriate_error {
    return Intl.message(
      'The topic you want to learn is inappropriate',
      name: 'create_course_inappropriate_error',
      desc: '',
      args: [],
    );
  }

  /// `Inappropriate topics are not allowed`
  String get create_course_inappropriate_warning {
    return Intl.message(
      'Inappropriate topics are not allowed',
      name: 'create_course_inappropriate_warning',
      desc: '',
      args: [],
    );
  }

  /// `{totalLessons} lesson(s)`
  String total_lessons(Object totalLessons) {
    return Intl.message(
      '$totalLessons lesson(s)',
      name: 'total_lessons',
      desc: '',
      args: [totalLessons],
    );
  }

  /// `Welcome to`
  String get welcome_text {
    return Intl.message(
      'Welcome to',
      name: 'welcome_text',
      desc: '',
      args: [],
    );
  }

  /// `Enter a topic to learn`
  String get enter_topic_hint {
    return Intl.message(
      'Enter a topic to learn',
      name: 'enter_topic_hint',
      desc: '',
      args: [],
    );
  }

  /// `Your courses`
  String get your_courses {
    return Intl.message(
      'Your courses',
      name: 'your_courses',
      desc: '',
      args: [],
    );
  }

  /// `Unbookmark Course`
  String get unbookmark_course_title {
    return Intl.message(
      'Unbookmark Course',
      name: 'unbookmark_course_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to unbookmark this course? \nPlease note that this will remove the course from your Firebase account and you won't be able to recover it.`
  String get unbookmark_course_text {
    return Intl.message(
      'Are you sure you want to unbookmark this course? \nPlease note that this will remove the course from your Firebase account and you won\'t be able to recover it.',
      name: 'unbookmark_course_text',
      desc: '',
      args: [],
    );
  }

  /// `Delete course`
  String get delete_course_title {
    return Intl.message(
      'Delete course',
      name: 'delete_course_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this course? \nThis will permanently remove the course from this app, and it will no longer appear in your courses list, unless you bookmark it and save it to your account.`
  String get delete_course_text {
    return Intl.message(
      'Are you sure you want to delete this course? \nThis will permanently remove the course from this app, and it will no longer appear in your courses list, unless you bookmark it and save it to your account.',
      name: 'delete_course_text',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes_button {
    return Intl.message(
      'Yes',
      name: 'yes_button',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no_button {
    return Intl.message(
      'No',
      name: 'no_button',
      desc: '',
      args: [],
    );
  }

  /// `Course successfully deleted`
  String get course_deleted_message {
    return Intl.message(
      'Course successfully deleted',
      name: 'course_deleted_message',
      desc: '',
      args: [],
    );
  }

  /// `You have {lessonsIncomplete} incomplete lessons.\nComplete them to generate more.`
  String incomplete_lessons_alert_text(Object lessonsIncomplete) {
    return Intl.message(
      'You have $lessonsIncomplete incomplete lessons.\nComplete them to generate more.',
      name: 'incomplete_lessons_alert_text',
      desc: '',
      args: [lessonsIncomplete],
    );
  }

  /// `Delete`
  String get delete_course {
    return Intl.message(
      'Delete',
      name: 'delete_course',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Lessons`
  String get lessons {
    return Intl.message(
      'Lessons',
      name: 'lessons',
      desc: '',
      args: [],
    );
  }

  /// `Course Overview`
  String get course_overview {
    return Intl.message(
      'Course Overview',
      name: 'course_overview',
      desc: '',
      args: [],
    );
  }

  /// `Overall Progress`
  String get overall_progress {
    return Intl.message(
      'Overall Progress',
      name: 'overall_progress',
      desc: '',
      args: [],
    );
  }

  /// `Continue where you left off`
  String get continue_where_left_off {
    return Intl.message(
      'Continue where you left off',
      name: 'continue_where_left_off',
      desc: '',
      args: [],
    );
  }

  /// `Generate new Lesson`
  String get generate_new_lesson {
    return Intl.message(
      'Generate new Lesson',
      name: 'generate_new_lesson',
      desc: '',
      args: [],
    );
  }

  /// `complete - {completedLessons} of {totalLessons} lessons completed`
  String course_completed(Object completedLessons, Object totalLessons) {
    return Intl.message(
      'complete - $completedLessons of $totalLessons lessons completed',
      name: 'course_completed',
      desc: '',
      args: [completedLessons, totalLessons],
    );
  }

  /// `Start Game`
  String get start_game_label {
    return Intl.message(
      'Start Game',
      name: 'start_game_label',
      desc: '',
      args: [],
    );
  }

  /// `Complete Lesson`
  String get complete_lesson_text {
    return Intl.message(
      'Complete Lesson',
      name: 'complete_lesson_text',
      desc: '',
      args: [],
    );
  }

  /// `You haven't saved any lessons yet`
  String get no_lessons_saved {
    return Intl.message(
      'You haven\'t saved any lessons yet',
      name: 'no_lessons_saved',
      desc: '',
      args: [],
    );
  }

  /// `Play Again`
  String get play_again_button {
    return Intl.message(
      'Play Again',
      name: 'play_again_button',
      desc: '',
      args: [],
    );
  }

  /// `Back to Lesson`
  String get back_to_lesson_button {
    return Intl.message(
      'Back to Lesson',
      name: 'back_to_lesson_button',
      desc: '',
      args: [],
    );
  }

  /// `Completion`
  String get completion_label {
    return Intl.message(
      'Completion',
      name: 'completion_label',
      desc: '',
      args: [],
    );
  }

  /// `Total Questions`
  String get total_question_label {
    return Intl.message(
      'Total Questions',
      name: 'total_question_label',
      desc: '',
      args: [],
    );
  }

  /// `Correct`
  String get correct_label {
    return Intl.message(
      'Correct',
      name: 'correct_label',
      desc: '',
      args: [],
    );
  }

  /// `Wrong`
  String get wrong_label {
    return Intl.message(
      'Wrong',
      name: 'wrong_label',
      desc: '',
      args: [],
    );
  }

  /// `Correct Answer:`
  String get correct_answer_prefix {
    return Intl.message(
      'Correct Answer:',
      name: 'correct_answer_prefix',
      desc: '',
      args: [],
    );
  }

  /// `You must select an answer to continue.`
  String get select_answer_warning {
    return Intl.message(
      'You must select an answer to continue.',
      name: 'select_answer_warning',
      desc: '',
      args: [],
    );
  }

  /// `Question {current}/{total}`
  String question_progress(Object current, Object total) {
    return Intl.message(
      'Question $current/$total',
      name: 'question_progress',
      desc: '',
      args: [current, total],
    );
  }

  /// `Previous`
  String get previous_button {
    return Intl.message(
      'Previous',
      name: 'previous_button',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit_button {
    return Intl.message(
      'Submit',
      name: 'submit_button',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next_button {
    return Intl.message(
      'Next',
      name: 'next_button',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to quit the quiz? All your progress will be lost.`
  String get quit_quiz_warning_message {
    return Intl.message(
      'Are you sure you want to quit the quiz? All your progress will be lost.',
      name: 'quit_quiz_warning_message',
      desc: '',
      args: [],
    );
  }

  /// `Warning!`
  String get quit_quiz_warning_title {
    return Intl.message(
      'Warning!',
      name: 'quit_quiz_warning_title',
      desc: '',
      args: [],
    );
  }

  /// `Quiz`
  String get quiz_title {
    return Intl.message(
      'Quiz',
      name: 'quiz_title',
      desc: '',
      args: [],
    );
  }

  /// `Cursos`
  String get statistic_courses {
    return Intl.message(
      'Cursos',
      name: 'statistic_courses',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get button_start {
    return Intl.message(
      'Start',
      name: 'button_start',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to LearnQuest`
  String get welcome_title_1 {
    return Intl.message(
      'Welcome to LearnQuest',
      name: 'welcome_title_1',
      desc: '',
      args: [],
    );
  }

  /// `Discover a world of personalized learning. Generate study paths tailored to your goals and preferences.`
  String get welcome_description_1 {
    return Intl.message(
      'Discover a world of personalized learning. Generate study paths tailored to your goals and preferences.',
      name: 'welcome_description_1',
      desc: '',
      args: [],
    );
  }

  /// `Explore and Learn`
  String get welcome_title_2 {
    return Intl.message(
      'Explore and Learn',
      name: 'welcome_title_2',
      desc: '',
      args: [],
    );
  }

  /// `Navigate through an interactive map, complete levels, and unlock worlds of knowledge. Learn while having fun.`
  String get welcome_description_2 {
    return Intl.message(
      'Navigate through an interactive map, complete levels, and unlock worlds of knowledge. Learn while having fun.',
      name: 'welcome_description_2',
      desc: '',
      args: [],
    );
  }

  /// `Customize and Connect`
  String get welcome_title_3 {
    return Intl.message(
      'Customize and Connect',
      name: 'welcome_title_3',
      desc: '',
      args: [],
    );
  }

  /// `Adjust your learning path according to your needs. Join a community of learners and share your progress.`
  String get welcome_description_3 {
    return Intl.message(
      'Adjust your learning path according to your needs. Join a community of learners and share your progress.',
      name: 'welcome_description_3',
      desc: '',
      args: [],
    );
  }

  /// `Oops... Something went wrong`
  String get snackbar_error_message {
    return Intl.message(
      'Oops... Something went wrong',
      name: 'snackbar_error_message',
      desc: '',
      args: [],
    );
  }

  /// `Continue as guest`
  String get continue_as_guest_button {
    return Intl.message(
      'Continue as guest',
      name: 'continue_as_guest_button',
      desc: '',
      args: [],
    );
  }

  /// `Log in with Google`
  String get log_in_with_google_button {
    return Intl.message(
      'Log in with Google',
      name: 'log_in_with_google_button',
      desc: '',
      args: [],
    );
  }

  /// `Guest`
  String get user_name {
    return Intl.message(
      'Guest',
      name: 'user_name',
      desc: '',
      args: [],
    );
  }

  /// `PREFERENCES`
  String get preferences_label {
    return Intl.message(
      'PREFERENCES',
      name: 'preferences_label',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language_option {
    return Intl.message(
      'Language',
      name: 'language_option',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get dark_mode_option {
    return Intl.message(
      'Dark Mode',
      name: 'dark_mode_option',
      desc: '',
      args: [],
    );
  }

  /// `ACCOUNT`
  String get account_label {
    return Intl.message(
      'ACCOUNT',
      name: 'account_label',
      desc: '',
      args: [],
    );
  }

  /// `Frequently Asked Questions`
  String get help_option {
    return Intl.message(
      'Frequently Asked Questions',
      name: 'help_option',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout_option {
    return Intl.message(
      'Logout',
      name: 'logout_option',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get idiom_text {
    return Intl.message(
      'English',
      name: 'idiom_text',
      desc: '',
      args: [],
    );
  }

  /// `What is LearnQuest?`
  String get faq_what_is_learnquest {
    return Intl.message(
      'What is LearnQuest?',
      name: 'faq_what_is_learnquest',
      desc: '',
      args: [],
    );
  }

  /// `LearnQuest is an innovative app designed to provide a personalized learning experience, offering interactive courses in various disciplines that allow you to progress at your own pace.`
  String get faq_what_is_learnquest_answer {
    return Intl.message(
      'LearnQuest is an innovative app designed to provide a personalized learning experience, offering interactive courses in various disciplines that allow you to progress at your own pace.',
      name: 'faq_what_is_learnquest_answer',
      desc: '',
      args: [],
    );
  }

  /// `How does LearnQuest work?`
  String get faq_how_does_learnquest_work {
    return Intl.message(
      'How does LearnQuest work?',
      name: 'faq_how_does_learnquest_work',
      desc: '',
      args: [],
    );
  }

  /// `LearnQuest uses advanced artificial intelligence technology to tailor educational content to your needs. You can follow interactive lessons, track your progress, and learn anytime, anywhere.`
  String get faq_how_does_learnquest_work_answer {
    return Intl.message(
      'LearnQuest uses advanced artificial intelligence technology to tailor educational content to your needs. You can follow interactive lessons, track your progress, and learn anytime, anywhere.',
      name: 'faq_how_does_learnquest_work_answer',
      desc: '',
      args: [],
    );
  }

  /// `Do I need to be connected to the Internet to use LearnQuest?`
  String get faq_need_internet {
    return Intl.message(
      'Do I need to be connected to the Internet to use LearnQuest?',
      name: 'faq_need_internet',
      desc: '',
      args: [],
    );
  }

  /// `Yes, an Internet connection is required to access the courses and lessons. However, we are working on implementing offline access features in future updates.`
  String get faq_need_internet_answer {
    return Intl.message(
      'Yes, an Internet connection is required to access the courses and lessons. However, we are working on implementing offline access features in future updates.',
      name: 'faq_need_internet_answer',
      desc: '',
      args: [],
    );
  }

  /// `How can I register for LearnQuest?`
  String get faq_how_to_register {
    return Intl.message(
      'How can I register for LearnQuest?',
      name: 'faq_how_to_register',
      desc: '',
      args: [],
    );
  }

  /// `You can register for LearnQuest using your email address or Google account. Simply download the app and follow the instructions to create your account.`
  String get faq_how_to_register_answer {
    return Intl.message(
      'You can register for LearnQuest using your email address or Google account. Simply download the app and follow the instructions to create your account.',
      name: 'faq_how_to_register_answer',
      desc: '',
      args: [],
    );
  }

  /// `Is LearnQuest free?`
  String get faq_is_learnquest_free {
    return Intl.message(
      'Is LearnQuest free?',
      name: 'faq_is_learnquest_free',
      desc: '',
      args: [],
    );
  }

  /// `Currently, LearnQuest is free. We offer full access to courses and lessons at no additional cost.`
  String get faq_is_learnquest_free_answer {
    return Intl.message(
      'Currently, LearnQuest is free. We offer full access to courses and lessons at no additional cost.',
      name: 'faq_is_learnquest_free_answer',
      desc: '',
      args: [],
    );
  }

  /// `Can I change the language of the app?`
  String get faq_change_language {
    return Intl.message(
      'Can I change the language of the app?',
      name: 'faq_change_language',
      desc: '',
      args: [],
    );
  }

  /// `Yes, LearnQuest is available in English and Spanish. You can change the language from the app's settings section.`
  String get faq_change_language_answer {
    return Intl.message(
      'Yes, LearnQuest is available in English and Spanish. You can change the language from the app\'s settings section.',
      name: 'faq_change_language_answer',
      desc: '',
      args: [],
    );
  }

  /// `How can I track my progress?`
  String get faq_track_progress {
    return Intl.message(
      'How can I track my progress?',
      name: 'faq_track_progress',
      desc: '',
      args: [],
    );
  }

  /// `Each course in LearnQuest has a progress section where you can see how many lessons you've completed and how many are left.`
  String get faq_track_progress_answer {
    return Intl.message(
      'Each course in LearnQuest has a progress section where you can see how many lessons you\'ve completed and how many are left.',
      name: 'faq_track_progress_answer',
      desc: '',
      args: [],
    );
  }

  /// `Can I access LearnQuest from multiple devices?`
  String get faq_multiple_devices {
    return Intl.message(
      'Can I access LearnQuest from multiple devices?',
      name: 'faq_multiple_devices',
      desc: '',
      args: [],
    );
  }

  /// `Yes, you can access your LearnQuest account from multiple devices. Just sign in with your account on each device to sync your progress.`
  String get faq_multiple_devices_answer {
    return Intl.message(
      'Yes, you can access your LearnQuest account from multiple devices. Just sign in with your account on each device to sync your progress.',
      name: 'faq_multiple_devices_answer',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
