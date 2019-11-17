import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    Key key,
    @required this.error,
  }) : super(key: key);

  final Exception error;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error!'),
      content: Text('Got message ${error.toString()}'),
    );
  }
}
