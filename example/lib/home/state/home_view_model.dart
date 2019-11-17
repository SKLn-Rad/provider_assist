import 'package:example/shared/events/present_dialog_event.dart';
import 'package:example/shared/views/error_dialog.dart';
import 'package:example/shared/views/hello_dialog.dart';
import 'package:flutter/material.dart';

import 'package:provider_assist/provider_assist.dart';

class HomeViewModel extends EventViewModel {
  HomeViewModel({
    @required this.providerAssist,
  }) : assert(providerAssist != null);

  //* ProviderAssist injects itself as a top level provider for you to access at any point
  final ProviderAssist providerAssist;
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

  @override
  Future<void> handleError(BuildContext context, Event event, Object error) async {
    final Exception ex = error as Exception;
    await showDialog<HelloDialog>(context: context, builder: (BuildContext context) => ErrorDialog(error: ex));
  }

  Future<void> sayHello(BuildContext context) async {
    await showDialog<HelloDialog>(context: context, builder: (BuildContext context) => const HelloDialog(sender: 'Home View'));
    hasCalledEvent = true;
    notifyListeners();
  }

  @override
  Future<void> onViewFirstLoad(BuildContext context) async {}
}
