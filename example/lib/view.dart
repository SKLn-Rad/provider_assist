import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_assist/provider_assist.dart';

import 'view_model.dart';

class View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ViewModel>(
      model: ViewModel(),
      onErrorOccured: (BuildContext context, String errorCode) {
        print("Got a new error: $errorCode");
      },
      onEventOccured: (BuildContext context, String event) {
        print("Got a new event: $event");
      },
      builder: (BuildContext context, ViewModel vm, LayoutInformation layout) {
        print("Device type: ${layout.deviceType}");
        print("Device orientation: ${layout.orientation}");
        return Scaffold(
          backgroundColor: layout.theme.backgroundColor,
          appBar: AppBar(
            title: Text(layout.translations['view_title']),
          ),
          body: Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CupertinoButton(
                  child: Text(layout.translations['view_raise_error']),
                  onPressed: () => vm.onErrorRequested(),
                ),
                SizedBox(height: 8.0),
                CupertinoButton(
                  child: Text(layout.translations['view_raise_event']),
                  onPressed: () => vm.onEventRequested(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
