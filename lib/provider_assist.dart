library provider_assist;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_assist/middleware/error_middleware.dart';
import 'package:provider_assist/middleware/event_middleware.dart';

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
  const ProviderAssist({
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

  final Widget wrappedChild;
  final List<SingleChildCloneableWidget> providers;
  final List<EventMiddleware<Event>> eventMiddleware;
  final List<ErrorMiddleware> errorMiddleware;
  final Map<Locale, Map<String, String>> localizations;

  @override
  InheritedElement createElement() {
    registerTranslations(localizations);
    return super.createElement();
  }

  @override
  Widget get child {
    return MultiProvider(
      providers: providers,
      child: wrappedChild,
    );
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}
