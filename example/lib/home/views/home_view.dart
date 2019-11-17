import 'package:example/home/state/home_view_model.dart';
import 'package:example/shared/events/present_dialog_event.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider_assist/provider_assist.dart';

class HomeView extends EventView<HomeViewModel> {
  @override
  HomeViewModel buildModel(BuildContext context) {
    return HomeViewModel(
      providerAssist: Provider.of(context),
    );
  }

  @override
  Widget buildView(BuildContext context, LayoutInformation layoutInformation, HomeViewModel model) {
    final String title = layoutInformation.translations['home_title'] ?? 'Default Title';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              child: const Text('Say Hello From Home'),
              onPressed: () async => dispatchEvent(context, model, PresentDialogEvent(false, false)),
            ),
            MaterialButton(
              child: const Text('Say Hello From Middleware'),
              onPressed: () async => dispatchEvent(context, model, PresentDialogEvent(true, false)),
            ),
            MaterialButton(
              child: const Text('Throw exception'),
              onPressed: () async => dispatchEvent(context, model, PresentDialogEvent(true, true)),
            ),
          ],
        ),
      ),
    );
  }
}
