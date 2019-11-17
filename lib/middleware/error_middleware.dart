import 'package:flutter/material.dart';

abstract class ErrorMiddleware {
  Future<void> handleEvent(BuildContext context, Widget sender, Object error);
  Future<bool> shouldHandle(BuildContext context, Widget sender, Object error);
  Future<bool> shouldAbsorb(BuildContext context, Widget sender, Object error);
}
