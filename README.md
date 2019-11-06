# Provider Assist

This is a simple package used to enhance the provider package with additional features for Flutter and a standard MVVM pattern. It is still very early and is still open to suggestions.

Note: This pattern is very heavily influenced by FilledStacks Provider v3 Architecture (Thanks a lot!)

## In a nutshell
This package wraps your top level views for each page in BaseView, this widget should pass in a model which extends BaseViewModel. Once you have wrapped your view, this package will give you callbacks and metadata during build which can be used to enhance the quality of your code.

## Breaking Change (1.5.0)
The onViewFirstLoad, onEventReceived, and onErrorReceived callback will now supply the model. Please update your code to include this additional parameter.
Apologies for this, this was an oversight on me but it will allow you to interact with your model immediately after the view is visible. This is useful for a number of things, e.g. checking if the user is logged in on a splash view.

## Lifecycle
![Lifecycle](https://raw.githubusercontent.com/SKLn-Rad/provider_assist/master/lifecycle.png)

## Features
1) Provide layout information on the builder of the view, this will include:
    1) Whether the device is a tablet or not (7" or above)
    2) Whether the device is landscape
2) Provide raising and handling of errors in your view model by implementing the onErrorOccured callback.
    1) Call notifyError in your ViewModel, passing it a error code as a string
    2) Implement the onErrorOccured function on your view to get the error code passed by the view model and act on it
3) Callbacks for onModelReady and onViewReady
    1) onModelReady will be run once when the models constructor has completed
    2) onViewReady will be run once when the view first renders to the screen
4) Basic translation and localization support
    1) You have to import the flutter localizations package in your pubspec, see the example
    2) Next call registerTranslations() from your main method, passing in a map of locales to key/value pairs
    3) The translations will then be passed down for your locale in the layoutInformation property in baseView
5) Generic event callback from ViewModel to View via notifyEvent and onEventOccured
    1) Call notifyEvent in your ViewModel, passing it a string representing the event
    2) Implement the onEventOccured function on your view to get the event passed by the view model and act on it
      1) This can be useful for telling the UI to navigate, for example when a user logins in
    
## Future Features
This is down to you! I use this on a daily basis so I will be adding features I find useful in everyday development. For example:
1) Improve Localization
2) Globally handling errors rather than implementing on each view (for example pushing an error page)
3) Passing further data down to the widget about the system. OS, etc...

## TODO
* Write tests to improve rating
* Improve documentation and example

## Example Main
```dart
void main() {
  registerTranslations(translations);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      // Swap below to change locale
      locale: Locale('en'),
      // locale: Locale('hi'),
      supportedLocales: <Locale>[
        Locale('en'),
        Locale('hi'),
      ],
      localizationsDelegates: <LocalizationsDelegate>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: View(),
    );
  }
}

Map<Locale, Map<String, String>> translations = {
  Locale('en'): {
    'view_title': 'Example Title',
    'view_raise_error': 'Raise Error',
    'view_raise_event': 'Raise Event',
  },
  Locale('hi'): {
    'view_title': 'उदाहरण शीर्षक',
    'view_raise_error': 'त्रुटि उठाएँ',
    'view_raise_event': 'घटना को बढ़ाएँ',
  },
};
```

### Example View
```dart
class View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ViewModel>(
      model: ViewModel(),
      onErrorOccured: (BuildContext context, ViewModel model, String errorCode) {
        print("Got a new error: $errorCode");
      },
      onEventOccured: (BuildContext context, ViewModel model, String event) {
        print("Got a new event: $event");
      },
      onModelReady: (ViewModel model) {
        print("Model is ready, but view is still not visible");
      },
      onViewFirstLoad: (BuildContext context, ViewModel model) {
        print("View is rendered");
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
```

### Example View Model
```dart
class ViewModel extends BaseViewModel {
  void onErrorRequested() {
    try {
      setBusy(true);
      notifyError('Random error');
    } finally {
      setBusy(false);
    }
  }

  void onEventRequested() {
    try {
      setBusy(true);
      notifyEvent('Random event');
    } finally {
      setBusy(false);
    }
  }
}
```
