import 'package:flutter/material.dart';
import 'package:provider_assist/enumerations/middleware_resolution.dart';

abstract class ErrorMiddleware {
  Future<MiddlewareResolution> handleEvent(BuildContext context, Widget sender, Object error);
}
