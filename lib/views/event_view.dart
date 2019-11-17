import 'dart:async';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:provider_assist/models/processed_event.dart';
import 'package:provider_assist/provider_assist.dart';

abstract class EventView<T extends EventViewModel> extends StatefulWidget {
  T buildModel(BuildContext context);
  Widget buildView(BuildContext context, LayoutInformation layoutInformation, T model);

  Future<void> onViewFirstLoad(BuildContext context, LayoutInformation layoutInformation, T model) async {}

  Future<void> dispatchEvent(BuildContext context, T model, Event event) async {
    await ProviderAssist.of(context).dispatchEvent(context, this, event);
  }

  @override
  _EventViewState<T> createState() => _EventViewState<T>();
}

class _EventViewState<T extends EventViewModel> extends State<EventView<T>> {
  T model;
  LayoutInformation layoutInformation;
  StreamSubscription<ProcessedEvent> processedEventStreamSubscription;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(onWidgetFirstBuilt);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProviderAssist providerAssist = ProviderAssist.of(context);
    processedEventStreamSubscription = providerAssist.processedEventStream.listen(onProcessedEvent);

    model ??= widget.buildModel(context);
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

  Future<void> onProcessedEvent(ProcessedEvent event) async {
    if (!mounted) {
      return;
    }

    try {
      if (event.hasError) {
        throw event.error;
      }
      await model.handleEvent(context, event.event);
    } catch (ex) {
      await model.handleError(context, event.event, ex);
    }
  }

  @override
  void dispose() {
    processedEventStreamSubscription?.cancel();
    super.dispose();
  }
}
