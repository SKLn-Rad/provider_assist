import 'package:flutter/material.dart';

class HelloDialog extends StatelessWidget {
  const HelloDialog({
    Key key,
    @required this.sender,
  }) : super(key: key);

  final String sender;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Greetings!'),
      content: Text('Hello from $sender!'),
    );
  }
}
