import 'package:flutter/material.dart';

class Localization {
  static Map<Locale, Map<String, String>> translations = <Locale, Map<String, String>>{
    const Locale('en'): <String, String>{
      'home_title': 'Provider Assist',
    },
    const Locale('hi'): <String, String>{
      'home_title': 'प्रदाता सहायता',
    },
  };
}
