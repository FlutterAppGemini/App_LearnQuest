// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(completedLessons, totalLessons) =>
      "completo - ${completedLessons} de ${totalLessons} lecciones completadas";

  static String m1(topic, iconList) =>
      "Genera un curso sobre el tema \'${topic}\'.";

  static String m2(courseTitle, summary) =>
      "Genera una nueva lección para el curso \'${courseTitle}\'. Aquí tienes un resumen de las últimas lecciones:\n${summary}\nContinúa el curso con una nueva lección relacionada con estos temas.";

  static String m3(topic) =>
      "¿El tema de ${topic} es inapropiado según los cánones de GeminiAI? la respuesta debe seguir el siguiente formato JSON: \n{ \n     \"reason\":  \"motivo explicando por qué es inapropiado o si no lo es\", \n     \"value\":  \"true o false (esto es un booleano)\" \n}";

  static String m4(iconList) =>
      "Estructura esperada para un curso nuevo: \n{ \n    \"title\":  \"titulo\", \n     \"icon\":  \"icono de la lista: ${iconList}\", \n    \"color\": \"es un String que representa un color pero en sistema hexadecimal(no incluyas el numeral)\", \n     \"description\":  \"descripcion breve de la materia o lo que se verá\", \n     \"lessons\": [ \n        { \n             \"title\":  \"titulo de la leccion\", \n             \"content\":  \"contenido de toda la leccion, información a modo de texto, lo más detallado y con ejemplos claros\", \n             \"game\": [ \n                { \n                     \"question\":  \"pregunta 1\", \n                     \"response\": [ \n                         \"respuesta 1\", \n                         \"respuesta 2\", \n                         \"respuesta 3\", \n                         \"respuesta 4\", \n                         \"respuesta 5\" \n                    ], \n                     \"solution\":  \"respuesta 1\" \n                } \n            ] \n        } \n    ] \n} \n Estructura esperada para la continuación de una lección: \n{ \n     \"title\":  \"titulo de la lección siguiente\", \n     \"content\":  \"contenido de toda la lección, información a modo de texto, lo más detallado y con ejemplos claros\", \n     \"progress\": 0.0, \n     \"game\": [ \n        { \n             \"question\":  \"pregunta 1\", \n             \"response\": [ \n                 \"respuesta 1\", \n                 \"respuesta 2\", \n                 \"respuesta 3\", \n                 \"respuesta 4\", \n                 \"respuesta 5\" \n            ], \n             \"solution\":  \"respuesta 1\" \n        } \n    ] \n} \n\n1. Al solicitar un curso inicial sobre un tema, la respuesta debe seguir la primera estructura.\n2. Al solicitar la continuación de una lección sobre un tema, la respuesta debe seguir la segunda estructura.\n3. \"game\" es un array de preguntas (entre 5 y 8).\n4. \"response\" es un array de respuestas (entre 4 y 7) donde 1 es correcta e irá como String en \"solution\".\n5. Al solicitar una nueva lección para un tema ya dado, se debe proporcionar contenido que avance de manera incremental, asegurando no repetir lecciones anteriores y mantener el contenido claro y bien explicado.\n6. No incluyas imágenes o links.";

  static String m5(lessonsIncomplete) =>
      "Tienes ${lessonsIncomplete} lecciones incompletas.\nCompletalas para generar más.";

  static String m6(current, total) => "Pregunta ${current}/${total}";

  static String m7(totalLessons) => "${totalLessons} lección(es)";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "account_label": MessageLookupByLibrary.simpleMessage("CUENTA"),
        "back_to_lesson_button":
            MessageLookupByLibrary.simpleMessage("Volver a la Lección"),
        "button_start": MessageLookupByLibrary.simpleMessage("Comenzar"),
        "complete_lesson_text":
            MessageLookupByLibrary.simpleMessage("Completar Lección"),
        "completion_label":
            MessageLookupByLibrary.simpleMessage("Finalización"),
        "continue_as_guest_button":
            MessageLookupByLibrary.simpleMessage("Continuar como invitado"),
        "continue_where_left_off":
            MessageLookupByLibrary.simpleMessage("Continúa donde lo dejaste"),
        "correct_answer_prefix":
            MessageLookupByLibrary.simpleMessage("Respuesta Correcta:"),
        "correct_label": MessageLookupByLibrary.simpleMessage("Correctas"),
        "course_completed": m0,
        "course_deleted_message":
            MessageLookupByLibrary.simpleMessage("Curso eliminado con éxito"),
        "course_overview":
            MessageLookupByLibrary.simpleMessage("Vista general del curso"),
        "create_course_inappropriate_error":
            MessageLookupByLibrary.simpleMessage(
                "El tema que deseas aprender es inapropiado"),
        "create_course_inappropriate_warning":
            MessageLookupByLibrary.simpleMessage(
                "Los temas inapropiados no están permitidos"),
        "dark_mode_option": MessageLookupByLibrary.simpleMessage("Modo Oscuro"),
        "delete_course": MessageLookupByLibrary.simpleMessage("Eliminar"),
        "delete_course_text": MessageLookupByLibrary.simpleMessage(
            "¿Estás seguro de que quieres eliminar este curso? \nEsto eliminará permanentemente el curso de esta aplicación, y ya no aparecerá en tu lista de cursos, a menos que lo marques y lo guardes en tu cuenta."),
        "delete_course_title":
            MessageLookupByLibrary.simpleMessage("Eliminar curso"),
        "description": MessageLookupByLibrary.simpleMessage("Descripción"),
        "enter_topic_hint": MessageLookupByLibrary.simpleMessage(
            "Ingresa un tema para aprender"),
        "faq_change_language": MessageLookupByLibrary.simpleMessage(
            "¿Puedo cambiar el idioma de la aplicación?"),
        "faq_change_language_answer": MessageLookupByLibrary.simpleMessage(
            "Sí, LearnQuest está disponible en inglés y español. Puedes cambiar el idioma desde la sección de configuración de la aplicación."),
        "faq_how_does_learnquest_work":
            MessageLookupByLibrary.simpleMessage("¿Cómo funciona LearnQuest?"),
        "faq_how_does_learnquest_work_answer": MessageLookupByLibrary.simpleMessage(
            "LearnQuest utiliza tecnología avanzada de inteligencia artificial para adaptar el contenido educativo a tus necesidades. Puedes seguir lecciones interactivas, realizar un seguimiento de tu progreso y aprender en cualquier momento y lugar."),
        "faq_how_to_register": MessageLookupByLibrary.simpleMessage(
            "¿Cómo puedo registrarme en LearnQuest?"),
        "faq_how_to_register_answer": MessageLookupByLibrary.simpleMessage(
            "Puedes registrarte en LearnQuest utilizando tu dirección de correo electrónico o tu cuenta de Google. Simplemente descarga la aplicación y sigue las instrucciones para crear tu cuenta."),
        "faq_is_learnquest_free": MessageLookupByLibrary.simpleMessage(
            "¿LearnQuest es una aplicación gratuita?"),
        "faq_is_learnquest_free_answer": MessageLookupByLibrary.simpleMessage(
            "Actualmente, LearnQuest es gratuito. Ofrecemos acceso completo a los cursos y lecciones sin costo adicional."),
        "faq_multiple_devices": MessageLookupByLibrary.simpleMessage(
            "¿Puedo acceder a LearnQuest desde varios dispositivos?"),
        "faq_multiple_devices_answer": MessageLookupByLibrary.simpleMessage(
            "Sí, puedes acceder a tu cuenta de LearnQuest desde múltiples dispositivos. Solo necesitas iniciar sesión con tu cuenta en cada dispositivo para sincronizar tu progreso."),
        "faq_need_internet": MessageLookupByLibrary.simpleMessage(
            "¿Es necesario estar conectado a Internet para usar LearnQuest?"),
        "faq_need_internet_answer": MessageLookupByLibrary.simpleMessage(
            "Sí, se requiere una conexión a Internet para acceder a los cursos y lecciones. Sin embargo, estamos trabajando en implementar funciones de acceso sin conexión en futuras actualizaciones."),
        "faq_track_progress": MessageLookupByLibrary.simpleMessage(
            "¿Cómo puedo hacer un seguimiento de mi progreso?"),
        "faq_track_progress_answer": MessageLookupByLibrary.simpleMessage(
            "Cada curso en LearnQuest tiene una sección de progreso donde puedes ver cuántas lecciones has completado y cuántas aún te quedan por completar."),
        "faq_what_is_learnquest":
            MessageLookupByLibrary.simpleMessage("¿Qué es LearnQuest?"),
        "faq_what_is_learnquest_answer": MessageLookupByLibrary.simpleMessage(
            "LearnQuest es una aplicación innovadora diseñada para ofrecer una experiencia de aprendizaje personalizada, con cursos interactivos en diversas disciplinas que te permiten avanzar a tu propio ritmo."),
        "gemini_create_course_prompt": m1,
        "gemini_create_lesson_prompt": m2,
        "gemini_is_inappropriate_prompt": m3,
        "gemini_system_instruction": m4,
        "generate_new_lesson":
            MessageLookupByLibrary.simpleMessage("Generar nueva lección"),
        "help_option":
            MessageLookupByLibrary.simpleMessage("Preguntas Frecuentes"),
        "idiom_text": MessageLookupByLibrary.simpleMessage("Español"),
        "incomplete_lessons_alert_text": m5,
        "language_option": MessageLookupByLibrary.simpleMessage("Idioma"),
        "lessons": MessageLookupByLibrary.simpleMessage("Lecciones"),
        "log_in_with_google_button":
            MessageLookupByLibrary.simpleMessage("Iniciar sesión con Google"),
        "logout_option": MessageLookupByLibrary.simpleMessage("Cerrar Sesión"),
        "next_button": MessageLookupByLibrary.simpleMessage("Siguiente"),
        "no_button": MessageLookupByLibrary.simpleMessage("No"),
        "no_lessons_saved": MessageLookupByLibrary.simpleMessage(
            "Aún no ha guardado ninguna lección"),
        "overall_progress":
            MessageLookupByLibrary.simpleMessage("Progreso general"),
        "play_again_button":
            MessageLookupByLibrary.simpleMessage("Jugar de Nuevo"),
        "preferences_label":
            MessageLookupByLibrary.simpleMessage("PREFERENCIAS"),
        "previous_button": MessageLookupByLibrary.simpleMessage("Anterior"),
        "question_progress": m6,
        "quit_quiz_warning_message": MessageLookupByLibrary.simpleMessage(
            "¿Estás seguro de que quieres salir del cuestionario? Todo tu progreso se perderá."),
        "quit_quiz_warning_title":
            MessageLookupByLibrary.simpleMessage("¡Advertencia!"),
        "quiz_title": MessageLookupByLibrary.simpleMessage("Cuestionario"),
        "select_answer_warning": MessageLookupByLibrary.simpleMessage(
            "Debes seleccionar una respuesta para continuar."),
        "snackbar_error_message":
            MessageLookupByLibrary.simpleMessage("Ups... Algo salió mal"),
        "start_game_label":
            MessageLookupByLibrary.simpleMessage("Iniciar Juego"),
        "statistic_courses": MessageLookupByLibrary.simpleMessage("Courses"),
        "submit_button": MessageLookupByLibrary.simpleMessage("Enviar"),
        "total_lessons": m7,
        "total_question_label":
            MessageLookupByLibrary.simpleMessage("Total de Preguntas"),
        "unbookmark_course_text": MessageLookupByLibrary.simpleMessage(
            "¿Estás seguro de que quieres desmarcar este curso? \nTen en cuenta que esto eliminará el curso de tu cuenta de Firebase y no podrás recuperarlo."),
        "unbookmark_course_title":
            MessageLookupByLibrary.simpleMessage("Desmarcar Curso"),
        "user_name": MessageLookupByLibrary.simpleMessage("Invitado"),
        "welcome_text": MessageLookupByLibrary.simpleMessage("Bienvenido a"),
        "wrong_label": MessageLookupByLibrary.simpleMessage("Incorrectas"),
        "yes_button": MessageLookupByLibrary.simpleMessage("Sí"),
        "your_courses": MessageLookupByLibrary.simpleMessage("Tus cursos")
      };
}
