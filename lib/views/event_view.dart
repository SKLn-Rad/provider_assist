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

  final List<Event> events;

  void onViewFirstLoad(BuildContext context, LayoutInformation layoutInformation, T model) {
    //* Override to do stuff on view first load
  }

  Future<void> dispatchEvent(BuildContext context, T model, Event event) async {
    final ProviderAssist providerAssist = context.inheritFromWidgetOfExactType(ProviderAssist);
    final List<EventMiddleware<Event>> eventMiddleware = providerAssist.eventMiddleware.where((EventMiddleware<Event> em) => em.eventType == event.runtimeType).toList();

    for (EventMiddleware<Event> middleware in eventMiddleware) {
      await middleware.handleEvent(context, event);
      final bool shouldAbsorb = await middleware.shouldAbsorb(context, event);
      if (shouldAbsorb) {
        return;
      }
    }

    await model.handleEvent(context, event);
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

  void onWidgetFirstBuilt(Duration timeStamp) {
    if (widget.onViewFirstLoad != null && mounted) {
      widget.onViewFirstLoad(context, layoutInformation, model);
    }
  }
}
