import 'package:flutter/material.dart';
import 'package:provider_assist/events/event.dart';

class ProcessedEvent {
  ProcessedEvent({
    @required this.event,
    @required this.sender,
    this.error,
  })  : assert(event != null),
        assert(sender != null);

  final Event event;
  final Object sender;
  final Object error;

  bool get hasError => error != null;
}
