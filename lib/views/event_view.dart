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
  StreamSubscription<ProcessedEvent> processedErrorStreamSubscription;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(onWidgetFirstBuilt);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProviderAssist providerAssist = ProviderAssist.of(context);
    processedEventStreamSubscription = providerAssist.processedEventStream.listen(onProcessedEvent);
    processedErrorStreamSubscription = providerAssist.processedErrorStream.listen(onProcessedError);

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
      await model.handleEvent(context, event.event);
    } catch (ex) {
      ProviderAssist.of(context).dispatchError(context, this, event.event, ex);
    }
  }

  Future<void> onProcessedError(ProcessedEvent event) async {
    if (!mounted) {
      return;
    }

    await model.handleError(context, event.event, event.error);
  }

  @override
  void dispose() {
    processedEventStreamSubscription?.cancel();
    processedErrorStreamSubscription?.cancel();
    super.dispose();
  }
}
