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
      builder: (BuildContext context, ViewModel vm, LayoutInformation layout) {
        print("Device is landscape: ${layout.isLandscape}");
        print("Device is tablet: ${layout.isTablet}");
        return Scaffold(
          appBar: AppBar(
            title: Text('Example'),
          ),
          body: Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: CupertinoButton(
              child: Text('Raise Error'),
              onPressed: () => vm.onButtonClicked,
            ),
          ),
        );
      },
    );
  }
}
