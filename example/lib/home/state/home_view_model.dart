import 'package:example/home/events/home_say_hello_event.dart';
import 'package:example/shared/views/hello_dialog.dart';
import 'package:flutter/material.dart';

import 'package:provider_assist/provider_assist.dart';

class HomeViewModel extends EventViewModel {
  @override
  Future<void> handleEvent(BuildContext context, Event event) async {
    switch (event.runtimeType) {
      case HomeSayHelloEvent:
        await sayHello(context);
        break;
    }
  }

  Future<void> sayHello(BuildContext context) async {
    await showDialog<HelloDialog>(context: context, builder: (BuildContext context) => const HelloDialog(sender: 'Home View'));
    notifyListeners();
  }
}
