import 'package:provider_assist/provider_assist.dart';

class ViewModel extends BaseViewModel {
  void onErrorRequested() {
    try {
      setBusy(true);
      notifyError('Random error');
    } finally {
      setBusy(false);
    }
  }

  void onEventRequested() {
    try {
      setBusy(true);
      notifyEvent('Random event');
    } finally {
      setBusy(false);
    }
  }
}
