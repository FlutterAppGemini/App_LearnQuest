import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learnquest/common/providers/course_provider.dart';
import 'package:learnquest/common/providers/locale_provider.dart';
import 'package:learnquest/common/routes/routes.dart';
import 'package:learnquest/feature/splash_screen.dart';
import 'package:learnquest/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:learnquest/generated/l10n.dart';
import 'package:learnquest/common/services/gemini_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await CourseProvider.initHive();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GeminiService.load(S.delegate.supportedLocales.first.languageCode);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => CourseProvider()),
    ChangeNotifierProvider(create: (_) => LocaleProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'LearnQuest',
          locale: localeProvider.locale,
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const SplashScreen(),
          onGenerateRoute: Routes.onGenerateRoute,
        );
      },
    );
  }
}
