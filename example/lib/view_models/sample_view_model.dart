import 'package:provider_assist/provider_assist.dart';

class SampleViewModel extends BaseViewModel {
  void onEventRequested() {
    try {
      setBusy(true);
      notifyEvent('Random event');
    } finally {
      setBusy(false);
    }
  }
}
