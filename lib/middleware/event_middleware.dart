import 'package:flutter/material.dart';
import 'package:provider_assist/enumerations/middleware_resolution.dart';
import 'package:provider_assist/provider_assist.dart';

abstract class EventMiddleware<T extends Event> {
  Future<MiddlewareResolution> handleEvent(BuildContext context, Widget sender, T t);
  bool matchesEventType(Event event) => event is T;
}
