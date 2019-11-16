import 'dart:async';

import 'package:flutter/material.dart';

@deprecated
class BaseViewModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;

  final StreamController<String> errorSubscription = StreamController<String>();
  Stream<String> get onErrorOccured => errorSubscription.stream;

  final StreamController<String> eventSubscription = StreamController<String>();
  Stream<String> get onEventOccured => eventSubscription.stream;

  void notifyError(String errorCode) {
    errorSubscription.sink.add(errorCode);
  }

  void notifyEvent(String event) {
    eventSubscription.sink.add(event);
  }

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  @override
  void dispose() {
    errorSubscription.close();
    eventSubscription?.close();
    super.dispose();
  }
}
