import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider_assist/events/event.dart';

abstract class EventViewModel with ChangeNotifier {
  Future<void> handleEvent(BuildContext context, Event event);
  Future<void> handleError(BuildContext context, Event event, Object error) async {}
  Future<void> onViewFirstLoad(BuildContext context) async {}
}
