import 'package:example/shared/views/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider_assist/provider_assist.dart';

class UnknownErrorMiddleware extends ErrorMiddleware {
  @override
  Future<void> handleEvent(BuildContext context, Widget sender, Object error) async {
    final Exception ex = error as Exception;
    await showDialog<ErrorDialog>(context: context, builder: (BuildContext context) => ErrorDialog(error: ex));
  }

  @override
  Future<bool> shouldAbsorb(BuildContext context, Widget sender, Object error) async {
    return true;
  }

  @override
  Future<bool> shouldHandle(BuildContext context, Widget sender, Object error) async {
    return error is Exception;
  }
}
