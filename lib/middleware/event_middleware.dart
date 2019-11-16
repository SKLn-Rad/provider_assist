import 'package:flutter/material.dart';
import 'package:provider_assist/provider_assist.dart';

abstract class EventMiddleware<T extends Event> {
  Future<void> handleEvent(BuildContext context, T t);
  Future<bool> shouldAbsorb(BuildContext context, T t);
  Type get eventType;
}
