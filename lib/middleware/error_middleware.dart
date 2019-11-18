import 'package:flutter/material.dart';
import 'package:provider_assist/enumerations/middleware_resolution.dart';
import 'package:provider_assist/events/event.dart';

abstract class ErrorMiddleware {
  Future<MiddlewareResolution> handleEvent(BuildContext context, Widget sender, Event event, Object error);
}
