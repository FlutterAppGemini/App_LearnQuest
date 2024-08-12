import 'dart:convert';

import 'package:dynamic_icons/dynamic_icons.dart';
import 'package:flutter/material.dart';
import 'package:learnquest/generated/l10n.dart';
import 'package:learnquest/common/services/gemini_service.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('en');
  static String iconList = jsonEncode(DynamicIcons.iconList.keys.toList());

  Locale get locale => _locale;

  void setLocale(Locale locale, BuildContext context) {
    if (!S.delegate.supportedLocales.contains(locale)) return;

    _locale = locale;
    notifyListeners();

    GeminiService.updateSystemInstruction(
        S.of(context).gemini_system_instruction(iconList));
  }

  void clearLocale() {
    _locale = const Locale('en');
    notifyListeners();
  }
}
