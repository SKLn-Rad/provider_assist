import 'package:flutter/material.dart';

@protected
Map<Locale, Map<String, String>> translations = <Locale, Map<String, String>>{};

void registerTranslations(Map<Locale, Map<String, String>> data) {
  translations = data;
}

Map<String, String> getTranslationsForLocale(Locale locale) {
  Map<String, String> localizedTranslations = <String, String>{};
  if (locale != null && translations.containsKey(locale)) {
    localizedTranslations = translations[locale];
  }

  return localizedTranslations;
}