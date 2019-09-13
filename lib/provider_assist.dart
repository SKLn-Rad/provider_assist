library provider_assist;

import 'package:flutter/material.dart';

export 'base_view.dart';
export 'base_view_model.dart';
export 'layout_information.dart';
export 'device_type.dart';

Map<Locale, Map<String, String>> _translations = {};
Map<Locale, Map<String, String>> get translations => _translations;

void registerTranslations(Map<Locale, Map<String, String>> translations) {
  _translations = translations;
}

Map<String, String> getTranslationsForLocale(Locale locale) {
  Map<String, String> translations = {};
  if (locale != null && _translations.containsKey(locale)) {
    translations = _translations[locale];
  }

  return translations;
}