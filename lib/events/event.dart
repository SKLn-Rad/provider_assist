import 'package:provider_assist/provider_assist.dart';

abstract class Event {
  Event(this.name);

  final String name;
}
