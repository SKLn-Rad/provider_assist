import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:example/view_models/sample_view_model.dart';
import 'package:provider_assist/provider_assist.dart';

class SampleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<SampleViewModel>(
      model: SampleViewModel(),
      onEventOccured: onEventOccured,
      onModelReady: onModelReady,
      onViewFirstLoad: onViewFirstLoad,
      builder: (BuildContext context, SampleViewModel vm, LayoutInformation layout) {
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

  void onEventOccured(BuildContext context, SampleViewModel model, dynamic event) {
    print('Got a new event $event');
  }

  void onModelReady(SampleViewModel viewModel) {
    print('Model is ready');
  }

  void onViewFirstLoad(BuildContext context, SampleViewModel model) {
    print('View rendered and ready');
  }
}
