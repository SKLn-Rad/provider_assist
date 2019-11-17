import 'package:example/home/views/home_view.dart';
import 'package:example/shared/events/present_dialog_event.dart';
import 'package:example/shared/views/hello_dialog.dart';
import 'package:flutter/material.dart';

import 'package:provider_assist/provider_assist.dart';

class DialogMiddleware extends EventMiddleware<PresentDialogEvent> {
  @override
  Future<void> handleEvent(BuildContext context, Widget sender, PresentDialogEvent t) async {
    if (t.throwException) {
      throw Exception('Sample exception');
    }

    await showDialog<HelloDialog>(context: context, builder: (BuildContext context) => const HelloDialog(sender: 'Middleware'));
  }

  @override
  Future<bool> shouldAbsorb(BuildContext context, Widget sender, PresentDialogEvent t) async {
    return true;
  }

  @override
  Future<bool> shouldHandle(BuildContext context, Widget sender, PresentDialogEvent t) async {
    return sender is HomeView && t.intercept;
  }
}
