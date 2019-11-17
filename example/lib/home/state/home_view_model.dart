import 'package:example/shared/events/present_dialog_event.dart';
import 'package:example/shared/views/hello_dialog.dart';
import 'package:flutter/material.dart';

import 'package:provider_assist/provider_assist.dart';

class HomeViewModel extends EventViewModel {
  bool hasCalledEvent = false;

  @override
  Future<void> handleEvent(BuildContext context, Event event) async {
    switch (event.runtimeType) {
      case PresentDialogEvent:
        await sayHello(context);
        break;
      default:
        print('Unknown event: ${event.runtimeType}');
        break;
    }
  }

  Future<void> sayHello(BuildContext context) async {
    await showDialog<HelloDialog>(context: context, builder: (BuildContext context) => const HelloDialog(sender: 'Home View'));
    hasCalledEvent = true;
    notifyListeners();
  }
}
