import 'package:provider_assist/events/event.dart';

class PresentDialogEvent extends Event {
  PresentDialogEvent(this.intercept, this.throwException);

  final bool intercept;
  final bool throwException;
}
