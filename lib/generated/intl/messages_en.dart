// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(completedLessons, totalLessons) =>
      "complete - ${completedLessons} of ${totalLessons} lessons completed";

  static String m1(topic, iconList) =>
      "Generate a course on the topic \'${topic}\'. Expected structure for a new course:\n{ \n    \"title\": \"title\", \n    \"icon\": \"icon from the list: ${iconList}\", \n    \"color\": \"A string representing a color in hexadecimal format (without the hash sign)\", \n    \"description\": \"Brief description of the subject or what will be covered\", \n    \"lessons\": [ \n        { \n            \"title\": \"Lesson title\", \n            \"content\": \"Detailed lesson content, provided in a clear and example-driven manner\", \n            \"game\": [ \n                { \n                    \"question\": \"Question 1\", \n                    \"response\": [ \n                        \"Answer 1\", \n                        \"Answer 2\", \n                        \"Answer 3\", \n                        \"Answer 4\", \n                        \"Answer 5\" \n                    ], \n                    \"solution\": \"Answer 1\" \n                } \n            ] \n        } \n    ] \n} \n Expected structure for a lesson continuation: \n{ \n    \"title\": \"Title of the next lesson\", \n    \"content\": \"Detailed content for the entire lesson, with clear examples\", \n    \"progress\": 0.0, \n    \"game\": [ \n        { \n            \"question\": \"Question 1\", \n            \"response\": [ \n                \"Answer 1\", \n                \"Answer 2\", \n                \"Answer 3\", \n                \"Answer 4\", \n                \"Answer 5\" \n            ], \n            \"solution\": \"Answer 1\" \n        } \n    ] \n}";

  static String m2(courseTitle, summary) =>
      "Generate a new lesson for the course \'${courseTitle}\'. Here is a summary of the last lessons:\n${summary}\nContinue the course with a new lesson related to these topics.Expected structure for a lesson continuation: \n{ \n    \"title\": \"Title of the next lesson\", \n    \"content\": \"Detailed content for the entire lesson, with clear examples\", \n    \"progress\": 0.0, \n    \"game\": [ \n        { \n            \"question\": \"Question 1\", \n            \"response\": [ \n                \"Answer 1\", \n                \"Answer 2\", \n                \"Answer 3\", \n                \"Answer 4\", \n                \"Answer 5\" \n            ], \n            \"solution\": \"Answer 1\" \n        } \n    ] \n} ";

  static String m3(topic) =>
      "Is the topic \'${topic}\' inappropriate according to GeminiAIs standards? the response should follow this JSON format: \n{ \n    \"reason\": \"Explanation of why the topic is inappropriate or if it is not\", \n    \"value\": \"true or false (this is a boolean)\" \n}";

  static String m4(iconList) =>
      "Expected structure for a new course: \n{ \n    \"title\": \"title\", \n    \"icon\": \"icon from the list: ${iconList}\", \n    \"color\": \"A string representing a color in hexadecimal format (without the hash sign)\", \n    \"description\": \"Brief description of the subject or what will be covered\", \n    \"lessons\": [ \n        { \n            \"title\": \"Lesson title\", \n            \"content\": \"Detailed lesson content, provided in a clear and example-driven manner\", \n            \"game\": [ \n                { \n                    \"question\": \"Question 1\", \n                    \"response\": [ \n                        \"Answer 1\", \n                        \"Answer 2\", \n                        \"Answer 3\", \n                        \"Answer 4\", \n                        \"Answer 5\" \n                    ], \n                    \"solution\": \"Answer 1\" \n                } \n            ] \n        } \n    ] \n} \n Expected structure for a lesson continuation: \n{ \n    \"title\": \"Title of the next lesson\", \n    \"content\": \"Detailed content for the entire lesson, with clear examples\", \n    \"progress\": 0.0, \n    \"game\": [ \n        { \n            \"question\": \"Question 1\", \n            \"response\": [ \n                \"Answer 1\", \n                \"Answer 2\", \n                \"Answer 3\", \n                \"Answer 4\", \n                \"Answer 5\" \n            ], \n            \"solution\": \"Answer 1\" \n        } \n    ] \n} \n\n1. When requesting an initial course on a topic, the response should follow the first structure.\n2. When requesting a continuation of a lesson on a topic, the response should follow the second structure.\n3. \"game\" is an array of questions (between 5 and 8).\n4. \"response\" is an array of answers (between 4 and 7), where one is correct and should be specified as a string in \"solution\".\n5. When requesting a new lesson for a previously given topic, the content should advance incrementally, avoiding repetition of previous lessons, and keeping the content clear and well-explained.\n6. Do not include images or links.";

  static String m5(lessonsIncomplete) =>
      "You have ${lessonsIncomplete} incomplete lessons.\nComplete them to generate more.";

  static String m6(current, total) => "Question ${current}/${total}";

  static String m7(totalLessons) => "${totalLessons} lesson(s)";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "account_label": MessageLookupByLibrary.simpleMessage("ACCOUNT"),
        "back_to_lesson_button":
            MessageLookupByLibrary.simpleMessage("Back to Lesson"),
        "button_start": MessageLookupByLibrary.simpleMessage("Start"),
        "complete_lesson_text":
            MessageLookupByLibrary.simpleMessage("Complete Lesson"),
        "completion_label": MessageLookupByLibrary.simpleMessage("Completion"),
        "continue_as_guest_button":
            MessageLookupByLibrary.simpleMessage("Continue as guest"),
        "continue_where_left_off":
            MessageLookupByLibrary.simpleMessage("Continue where you left off"),
        "correct_answer_prefix":
            MessageLookupByLibrary.simpleMessage("Correct Answer:"),
        "correct_label": MessageLookupByLibrary.simpleMessage("Correct"),
        "course_completed": m0,
        "course_deleted_message":
            MessageLookupByLibrary.simpleMessage("Course successfully deleted"),
        "course_overview":
            MessageLookupByLibrary.simpleMessage("Course Overview"),
        "create_course_inappropriate_error":
            MessageLookupByLibrary.simpleMessage(
                "The topic you want to learn is inappropriate"),
        "create_course_inappropriate_warning":
            MessageLookupByLibrary.simpleMessage(
                "Inappropriate topics are not allowed"),
        "dark_mode_option": MessageLookupByLibrary.simpleMessage("Dark Mode"),
        "delete_course": MessageLookupByLibrary.simpleMessage("Delete"),
        "delete_course_text": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this course? \nThis will permanently remove the course from this app, and it will no longer appear in your courses list, unless you bookmark it and save it to your account."),
        "delete_course_title":
            MessageLookupByLibrary.simpleMessage("Delete course"),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "enter_topic_hint":
            MessageLookupByLibrary.simpleMessage("Enter a topic to learn"),
        "faq_change_language": MessageLookupByLibrary.simpleMessage(
            "Can I change the language of the app?"),
        "faq_change_language_answer": MessageLookupByLibrary.simpleMessage(
            "Yes, LearnQuest is available in English and Spanish. You can change the language from the app\'s settings section."),
        "faq_how_does_learnquest_work":
            MessageLookupByLibrary.simpleMessage("How does LearnQuest work?"),
        "faq_how_does_learnquest_work_answer": MessageLookupByLibrary.simpleMessage(
            "LearnQuest uses advanced artificial intelligence technology to tailor educational content to your needs. You can follow interactive lessons, track your progress, and learn anytime, anywhere."),
        "faq_how_to_register": MessageLookupByLibrary.simpleMessage(
            "How can I register for LearnQuest?"),
        "faq_how_to_register_answer": MessageLookupByLibrary.simpleMessage(
            "You can register for LearnQuest using your email address or Google account. Simply download the app and follow the instructions to create your account."),
        "faq_is_learnquest_free":
            MessageLookupByLibrary.simpleMessage("Is LearnQuest free?"),
        "faq_is_learnquest_free_answer": MessageLookupByLibrary.simpleMessage(
            "Currently, LearnQuest is free. We offer full access to courses and lessons at no additional cost."),
        "faq_multiple_devices": MessageLookupByLibrary.simpleMessage(
            "Can I access LearnQuest from multiple devices?"),
        "faq_multiple_devices_answer": MessageLookupByLibrary.simpleMessage(
            "Yes, you can access your LearnQuest account from multiple devices. Just sign in with your account on each device to sync your progress."),
        "faq_need_internet": MessageLookupByLibrary.simpleMessage(
            "Do I need to be connected to the Internet to use LearnQuest?"),
        "faq_need_internet_answer": MessageLookupByLibrary.simpleMessage(
            "Yes, an Internet connection is required to access the courses and lessons. However, we are working on implementing offline access features in future updates."),
        "faq_track_progress": MessageLookupByLibrary.simpleMessage(
            "How can I track my progress?"),
        "faq_track_progress_answer": MessageLookupByLibrary.simpleMessage(
            "Each course in LearnQuest has a progress section where you can see how many lessons you\'ve completed and how many are left."),
        "faq_what_is_learnquest":
            MessageLookupByLibrary.simpleMessage("What is LearnQuest?"),
        "faq_what_is_learnquest_answer": MessageLookupByLibrary.simpleMessage(
            "LearnQuest is an innovative app designed to provide a personalized learning experience, offering interactive courses in various disciplines that allow you to progress at your own pace."),
        "gemini_create_course_prompt": m1,
        "gemini_create_lesson_prompt": m2,
        "gemini_is_inappropriate_prompt": m3,
        "gemini_system_instruction": m4,
        "generate_new_lesson":
            MessageLookupByLibrary.simpleMessage("Generate new Lesson"),
        "help_option":
            MessageLookupByLibrary.simpleMessage("Frequently Asked Questions"),
        "idiom_text": MessageLookupByLibrary.simpleMessage("English"),
        "incomplete_lessons_alert_text": m5,
        "language_option": MessageLookupByLibrary.simpleMessage("Language"),
        "lessons": MessageLookupByLibrary.simpleMessage("Lessons"),
        "log_in_with_google_button":
            MessageLookupByLibrary.simpleMessage("Log in with Google"),
        "logout_option": MessageLookupByLibrary.simpleMessage("Logout"),
        "next_button": MessageLookupByLibrary.simpleMessage("Next"),
        "no_button": MessageLookupByLibrary.simpleMessage("No"),
        "no_lessons_saved": MessageLookupByLibrary.simpleMessage(
            "You haven\'t saved any lessons yet"),
        "overall_progress":
            MessageLookupByLibrary.simpleMessage("Overall Progress"),
        "play_again_button": MessageLookupByLibrary.simpleMessage("Play Again"),
        "preferences_label":
            MessageLookupByLibrary.simpleMessage("PREFERENCES"),
        "previous_button": MessageLookupByLibrary.simpleMessage("Previous"),
        "question_progress": m6,
        "quit_quiz_warning_message": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to quit the quiz? All your progress will be lost."),
        "quit_quiz_warning_title":
            MessageLookupByLibrary.simpleMessage("Warning!"),
        "quiz_title": MessageLookupByLibrary.simpleMessage("Quiz"),
        "select_answer_warning": MessageLookupByLibrary.simpleMessage(
            "You must select an answer to continue."),
        "snackbar_error_message": MessageLookupByLibrary.simpleMessage(
            "Oops... Something went wrong"),
        "start_game_label": MessageLookupByLibrary.simpleMessage("Start Game"),
        "statistic_courses": MessageLookupByLibrary.simpleMessage("Cursos"),
        "submit_button": MessageLookupByLibrary.simpleMessage("Submit"),
        "total_lessons": m7,
        "total_question_label":
            MessageLookupByLibrary.simpleMessage("Total Questions"),
        "unbookmark_course_text": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to unbookmark this course? \nPlease note that this will remove the course from your Firebase account and you won\'t be able to recover it."),
        "unbookmark_course_title":
            MessageLookupByLibrary.simpleMessage("Unbookmark Course"),
        "user_name": MessageLookupByLibrary.simpleMessage("Guest"),
        "welcome_text": MessageLookupByLibrary.simpleMessage("Welcome to"),
        "wrong_label": MessageLookupByLibrary.simpleMessage("Wrong"),
        "yes_button": MessageLookupByLibrary.simpleMessage("Yes"),
        "your_courses": MessageLookupByLibrary.simpleMessage("Your courses")
      };
}
