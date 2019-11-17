import 'package:flutter/material.dart';
import 'package:provider_assist/provider_assist.dart';

abstract class EventMiddleware<T extends Event> {
  Future<void> handleEvent(BuildContext context, Widget sender, T t);
  Future<bool> shouldHandle(BuildContext context, Widget sender, T t);
  Future<bool> shouldAbsorb(BuildContext context, Widget sender, T t);

  bool matchesEventType(Event event) => event is T;
}
