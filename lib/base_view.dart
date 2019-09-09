import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_assist/base_view_model.dart';
import 'package:provider_assist/provider_assist.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, LayoutInformation layoutInformation) builder;
  final T model;
  final Function(T) onModelReady;
  final Function(BuildContext context) onViewFirstLoad;
  final Function(BuildContext context, String errorCode) onErrorOccured;

  BaseView({
    Key key,
    this.builder,
    this.model,
    this.onModelReady,
    this.onViewFirstLoad,
    this.onErrorOccured,
  }) : super(key: key);

  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  BaseViewModel model;
  StreamSubscription<String> errorSubscription;
  LayoutInformation layoutInformation;

  @override
  void initState() {
    model = widget.model;

    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }

    errorSubscription = model.onErrorOccured.listen(onErrorOccured);
    WidgetsBinding.instance.addPostFrameCallback(onWidgetFirstBuilt);
    super.initState();
  }

  void onErrorOccured(String event) {
    if (widget.onErrorOccured != null && mounted) {
      widget.onErrorOccured(context, event);
    }
  }

  void onWidgetFirstBuilt(Duration timeStamp) {
    if (widget.onViewFirstLoad != null && mounted) {
      widget.onViewFirstLoad(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    layoutInformation = LayoutInformation(context);
    return ChangeNotifierProvider<T>(
      builder: (context) => model,
      child: Consumer<T>(
        builder: (BuildContext context, T t, Widget child) => widget.builder(context, t, layoutInformation),
      ),
    );
  }

  @override
  void dispose() {
    errorSubscription.cancel();
    super.dispose();
  }
}
