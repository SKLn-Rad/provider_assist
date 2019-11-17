import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_assist/provider_assist.dart';

abstract class EventView<T extends EventViewModel> extends StatefulWidget {
  const EventView({
    Key key,
    this.events = const <Event>[],
  })  : assert(events != null),
        super(key: key);

  T buildModel();
  Widget buildView(BuildContext context, LayoutInformation layoutInformation, T model);

  Future<void> onEventStarted(BuildContext context, T model, Event event) async {}
  Future<void> onEventFinished(BuildContext context, T model, Event event) async {}
  Future<void> onEventError(BuildContext context, Object error, T model, Event event) async {}
  Future<void> onViewFirstLoad(BuildContext context, LayoutInformation layoutInformation, T model) async {}

  final List<Event> events;

  Future<void> dispatchEvent(BuildContext context, T model, Event event) async {
    final ProviderAssist providerAssist = context.inheritFromWidgetOfExactType(ProviderAssist);
    final List<EventMiddleware<Event>> eventMiddleware = providerAssist.eventMiddleware;
    final List<ErrorMiddleware> errorMiddleware = providerAssist.errorMiddleware;

    await onEventStarted(context, model, event);

    try {
      for (EventMiddleware<Event> middleware in eventMiddleware) {
        if (!middleware.matchesEventType(event)) {
          continue;
        }

        final bool shouldHandle = await middleware.shouldHandle(context, this, event);
        if (!shouldHandle) {
          continue;
        }

        await middleware.handleEvent(context, this, event);
        final bool shouldAbsorb = await middleware.shouldAbsorb(context, this, event);
        if (shouldAbsorb) {
          return;
        }
      }

      await model.handleEvent(context, event);
      await onEventFinished(context, model, event);
    } catch (ex) {
      for (ErrorMiddleware middleware in errorMiddleware) {
        final bool shouldHandle = await middleware.shouldHandle(context, this, ex);
        if (!shouldHandle) {
          continue;
        }

        await middleware.handleEvent(context, this, ex);
        final bool shouldAbsorb = await middleware.shouldAbsorb(context, this, ex);
        if (shouldAbsorb) {
          return;
        }
      }

      await onEventError(context, ex, model, event);
    }
  }

  @override
  _EventViewState<T> createState() => _EventViewState<T>();
}

class _EventViewState<T extends EventViewModel> extends State<EventView<T>> {
  T model;
  LayoutInformation layoutInformation;

  @override
  void initState() {
    model ??= widget.buildModel();
    WidgetsBinding.instance.addPostFrameCallback(onWidgetFirstBuilt);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    layoutInformation ??= LayoutInformation(context: context);
    return ChangeNotifierProvider<T>(
      builder: (_) => model,
      child: Consumer<T>(
        builder: (BuildContext context, T model, _) => widget.buildView(context, layoutInformation, model),
      ),
    );
  }

  Future<void> onWidgetFirstBuilt(Duration timeStamp) async {
    if (widget.onViewFirstLoad != null && mounted) {
      await widget.onViewFirstLoad(context, layoutInformation, model);
      await model.onViewFirstLoad(context);
    }
  }
}