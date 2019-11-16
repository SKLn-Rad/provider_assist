import 'package:example/shared/events/present_dialog_event.dart';
import 'package:example/shared/views/hello_dialog.dart';
import 'package:flutter/material.dart';

import 'package:provider_assist/provider_assist.dart';

class DialogMiddleware extends EventMiddleware<PresentDialogEvent> {
  @override
  Future<void> handleEvent(BuildContext context, Event t) async {
    await showDialog<HelloDialog>(context: context, builder: (BuildContext context) => const HelloDialog(sender: 'Middleware'));
  }

  @override
  Type get eventType => PresentDialogEvent;

  @override
  Future<bool> shouldAbsorb(BuildContext context, PresentDialogEvent t) async {
    return true;
  }
}
