import 'package:example/home/views/home_view.dart';
import 'package:example/shared/middleware/dialog_middleware.dart';
import 'package:flutter/material.dart';
import 'package:provider_assist/provider_assist.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderAssist(
      eventMiddleware: <EventMiddleware<Event>>[
        DialogMiddleware(),
      ],
      child: MaterialApp(
        home: HomeView(),
      ),
    );
  }
}
