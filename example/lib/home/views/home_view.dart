import 'package:example/home/events/home_say_hello_event.dart';
import 'package:example/home/state/home_view_model.dart';
import 'package:example/shared/events/present_dialog_event.dart';

import 'package:flutter/material.dart';
import 'package:provider_assist/provider_assist.dart';

class HomeView extends EventView<HomeViewModel> {
  //! This is not meant to be stateful, but is merely used to show how you MUST call notifyListeners inside handleEvent to update the state
  int rebuilds = 0;

  @override
  HomeViewModel buildModel() {
    return HomeViewModel();
  }

  @override
  Widget buildView(BuildContext context, LayoutInformation layoutInformation, HomeViewModel model) {
    rebuilds++;
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              child: const Text('Say Hello From Home and rebuild'),
              onPressed: () async => dispatchEvent(context, model, HomeSayHelloEvent()),
            ),
            const SizedBox(height: 12.0),
            MaterialButton(
              child: const Text('Say Hello From Middleware'),
              onPressed: () async => dispatchEvent(context, model, PresentDialogEvent()),
            ),
            const SizedBox(height: 24.0),
            Text('Rebuilds: $rebuilds'),
          ],
        ),
      ),
    );
  }
}
