import 'package:flutter/material.dart';
import 'package:provider_assist/provider_assist.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'view.dart';

void main() {
  registerTranslations(translations);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      // Swap below to change locale
      locale: Locale('en'),
      // locale: Locale('hi'),
      supportedLocales: <Locale>[
        Locale('en'),
        Locale('hi'),
      ],
      localizationsDelegates: <LocalizationsDelegate>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: View(),
    );
  }
}

Map<Locale, Map<String, String>> translations = {
  Locale('en'): {
    'view_title': 'Example Title',
    'view_raise_error': 'Raise Error',
    'view_raise_event': 'Raise Event',
  },
  Locale('hi'): {
    'view_title': 'उदाहरण शीर्षक',
    'view_raise_error': 'त्रुटि उठाएँ',
    'view_raise_event': 'घटना को बढ़ाएँ',
  },
};
