import 'package:provider_assist/provider_assist.dart';

class ViewModel extends BaseViewModel {
  void onButtonClicked() {
    try {
      setBusy(true);
      notifyError('Random error');
    } finally {
      setBusy(false);
    }
  }
}