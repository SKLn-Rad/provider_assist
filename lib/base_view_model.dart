import 'dart:async';

import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;

  final StreamController<String> errorSubscription = StreamController<String>();
  Stream<String> get onErrorOccured => errorSubscription.stream;

  void notifyError(String errorCode) {
    errorSubscription.sink.add(errorCode);
  }

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  @override
  void dispose() {
    errorSubscription.close();
    super.dispose();
  }
}
