library provider_assist;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_assist/enumerations/middleware_resolution.dart';
import 'package:provider_assist/middleware/error_middleware.dart';
import 'package:provider_assist/middleware/event_middleware.dart';
import 'package:provider_assist/models/processed_event.dart';

import 'adapters/localization_information.dart';
import 'events/event.dart';

export 'adapters/layout_information.dart';
export 'adapters/localization_information.dart';

export 'enumerations/device_type.dart';
export 'enumerations/middleware_resolution.dart';
export 'events/event.dart';

export 'middleware/error_middleware.dart';
export 'middleware/event_middleware.dart';

export 'view_models/base_view_model.dart';
export 'view_models/event_view_model.dart';

export 'views/base_view.dart';
export 'views/event_view.dart';

class ProviderAssist extends InheritedWidget {
  ProviderAssist({
    Key key,
    @required Widget child,
    this.eventMiddleware = const <EventMiddleware<Event>>[],
    this.errorMiddleware = const <ErrorMiddleware>[],
    this.providers = const <SingleChildCloneableWidget>[],
    this.localizations = const <Locale, Map<String, String>>{},
  })  : assert(child != null),
        assert(eventMiddleware != null),
        assert(errorMiddleware != null),
        assert(providers != null),
        assert(localizations != null),
        wrappedChild = child,
        super(key: key);

  factory ProviderAssist.of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ProviderAssist);
  }

  final Widget wrappedChild;
  final List<SingleChildCloneableWidget> providers;
  final List<EventMiddleware<Event>> eventMiddleware;
  final List<ErrorMiddleware> errorMiddleware;
  final Map<Locale, Map<String, String>> localizations;

  final StreamController<ProcessedEvent> processedEventStreamController = StreamController<ProcessedEvent>.broadcast();
  final StreamController<ProcessedEvent> processedErrorStreamController = StreamController<ProcessedEvent>.broadcast();

  Stream<ProcessedEvent> get processedEventStream => processedEventStreamController.stream;
  Function(ProcessedEvent) get addProcessedEvent => processedEventStreamController.sink.add;

  Stream<ProcessedEvent> get processedErrorStream => processedErrorStreamController.stream;
  Function(ProcessedEvent) get addProcessedError => processedErrorStreamController.sink.add;

  @override
  InheritedElement createElement() {
    registerTranslations(localizations);
    return super.createElement();
  }

  @override
  Widget get child {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        Provider<ProviderAssist>.value(value: this),
        ...providers,
      ],
      child: wrappedChild,
    );
  }

  Future<void> dispatchEvent(BuildContext context, Object sender, Event event) async {
    try {
      for (EventMiddleware<Event> middleware in eventMiddleware) {
        if (!middleware.matchesEventType(event)) {
          continue;
        }

        final MiddlewareResolution resolution = await middleware.handleEvent(context, sender, event);
        if (resolution == MiddlewareResolution.Absorb) {
          return;
        }
      }

      addProcessedEvent(ProcessedEvent(event: event, sender: sender));
    } catch (ex) {
      dispatchError(context, sender, event, ex);
    }
  }

  Future<void> dispatchError(BuildContext context, Object sender, Event event, Object error) async {
    for (ErrorMiddleware middleware in errorMiddleware) {
      final MiddlewareResolution resolution = await middleware.handleEvent(context, sender, event);
      if (resolution == MiddlewareResolution.Absorb) {
        return;
      }
    }

    addProcessedError(ProcessedEvent(event: event, sender: sender, error: error));
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}
