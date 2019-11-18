import 'package:example/shared/views/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider_assist/provider_assist.dart';

class UnknownErrorMiddleware extends ErrorMiddleware {
  @override
  Future<MiddlewareResolution> handleEvent(BuildContext context, Widget sender, Event event, Object error) async {
    final bool shouldHandle = error is Exception;
    if (!shouldHandle) {
      return MiddlewareResolution.Passthrough;
    }

    final Exception ex = error as Exception;
    await showDialog<ErrorDialog>(context: context, builder: (BuildContext context) => ErrorDialog(error: ex));
    return MiddlewareResolution.Absorb;
  }
}
