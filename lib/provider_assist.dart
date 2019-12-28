library provider_assist;

import 'package:flutter/material.dart';

export 'views/base_view.dart';
export 'view_models/base_view_model.dart';

export 'helpers/layout_information.dart';
export 'helpers/device_type.dart';

class ProviderAssist {
  ProviderAssist._();
  static final ProviderAssist instance = ProviderAssist._();

  Map<Locale, Map<String, String>> _translations = <Locale, Map<String, String>>{};
  Map<Locale, Map<String, String>> get translations => _translations;

  String safelyTranslateByKey(Locale locale, String key) {
    if (!_translations.containsKey(locale)) {
      return '';
    }

    return _translations[locale].containsKey(key) ? _translations[locale] : '';
  }

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
}
