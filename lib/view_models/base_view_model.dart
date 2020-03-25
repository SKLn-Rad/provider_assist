import 'dart:async';

import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;

  final StreamController<dynamic> eventSubscription = StreamController<dynamic>();
  Stream<dynamic> get onEventOccured => eventSubscription.stream;

  void notifyEvent(dynamic event) {
    if (eventSubscription == null || eventSubscription.isClosed) {
      return;
    }
    
    eventSubscription.sink.add(event);
  }

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  @override
  void dispose() {
    eventSubscription?.close();
    super.dispose();
  }
}
