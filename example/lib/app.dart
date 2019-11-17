import 'package:example/constants/localizations.dart';
import 'package:example/home/views/home_view.dart';
import 'package:example/shared/middleware/dialog_middleware.dart';
import 'package:example/shared/middleware/unknown_error_middleware.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider_assist/provider_assist.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderAssist(
      localizations: Localization.translations,
      eventMiddleware: <EventMiddleware<Event>>[
        DialogMiddleware(),
      ],
      errorMiddleware: <ErrorMiddleware>[
        UnknownErrorMiddleware(),
      ],
      child: MaterialApp(
        locale: const Locale('en'),
        // locale: const Locale('hi'),
        supportedLocales: const <Locale>[
          Locale('en'),
          Locale('hi'),
        ],
        localizationsDelegates: const <LocalizationsDelegate>[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: HomeView(),
      ),
    );
  }
}
