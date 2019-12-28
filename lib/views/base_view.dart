import 'dart:async';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:provider_assist/provider_assist.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, LayoutInformation layoutInformation) builder;
  final T model;
  final Function(T) onModelReady;
  final Function(BuildContext context, T model) onViewFirstLoad;
  final Function(BuildContext context, T model, dynamic event) onEventOccured;

  BaseView({
    Key key,
    this.builder,
    this.model,
    this.onModelReady,
    this.onViewFirstLoad,
    this.onEventOccured,
  }) : super(key: key);

  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  BaseViewModel model;
  StreamSubscription<dynamic> eventSubscription;
  LayoutInformation layoutInformation;

  @override
  void initState() {
    model = widget.model;

    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }

    eventSubscription = model.onEventOccured?.listen(onEventOccured);
    WidgetsBinding.instance.addPostFrameCallback(onWidgetFirstBuilt);
    super.initState();
  }

  void onEventOccured(dynamic event) {
    if (widget.onEventOccured != null && mounted) {
      widget.onEventOccured(context, model, event);
      setState(() {});
    }
  }

  void onWidgetFirstBuilt(Duration timeStamp) {
    if (widget.onViewFirstLoad != null && mounted) {
      widget.onViewFirstLoad(context, model);
    }
  }

  @override
  Widget build(BuildContext context) {
    layoutInformation = LayoutInformation(context);
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
        builder: (BuildContext context, T t, Widget child) => widget.builder(context, t, layoutInformation),
      ),
    );
  }

  @override
  void dispose() {
    eventSubscription?.cancel();
    super.dispose();
  }
}
