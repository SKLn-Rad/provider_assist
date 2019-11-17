import 'package:example/home/views/home_view.dart';
import 'package:example/shared/events/present_dialog_event.dart';
import 'package:example/shared/views/hello_dialog.dart';
import 'package:flutter/material.dart';

import 'package:provider_assist/provider_assist.dart';

class DialogMiddleware extends EventMiddleware<PresentDialogEvent> {
  @override
  Future<MiddlewareResolution> handleEvent(BuildContext context, Widget sender, PresentDialogEvent t) async {
    final bool shouldHandle = sender is HomeView && t.intercept;
    if (!shouldHandle) {
      return MiddlewareResolution.Passthrough;
    }

    if (t.throwException) {
      throw Exception('Sample exception');
    }

    await showDialog<HelloDialog>(context: context, builder: (BuildContext context) => const HelloDialog(sender: 'Middleware'));
    return MiddlewareResolution.Absorb;
  }
}
