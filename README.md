
#  Provider Assist

Provider assist is a ton of helpful tools designed to improve development within Flutter even further!

This project is a brainchild of mine and is the core of any flutter application I personally develop. It serves these purposes:

## Breaking Change (2.0.0)
As well as moving to Provider version 4.0.0. A lot of minor quality of life improvements have been done to make using this a lot easier.  
To name a few:
1) Events are now dynamic, meaning you can pass anything as an event
2) All global functions are now in the ProviderAssist singleton class, meaning it can be mocked easier
3) Errors have been removed to reduce the amount of streams in a BaseView. As they're events in their own right, pass them as events

In short, see the new example project for all the updates!

## Lifecycle
![Lifecycle](https://raw.githubusercontent.com/SKLn-Rad/provider_assist/master/lifecycle.png)

##  A note to users from Provider 1.*
As stated above, I hope for this framework to evolve as I encounter errors and directly reflect what I consider to be good practice at the time.
Version 2 onwards is an example of how I have identified weakness in the first version and have updated as such.

Because I don't want to break anyone elses code, I have kept the original functionality in place so you will not have to update your code, however I do recommend giving version 2 a go!
Thanks for your support!

## Layout Information
This is a handy helper which is automatically passed into your build function in views.
It will supply a number of useful properties about the devices, as well as the localizations for your current Locale if you registered them earlier.

Note: This is an inherited widget so if there are times when you require it outside of the view, you can obtain it anytime by doing the following.
```dart
void main() {
  ProviderAssist.instance.registerTranslations(translations);
  runApp(MyApp());
}
```
### Example View
```dart
class  HomeView  extends  EventView<HomeViewModel> {
	@override
	HomeViewModel buildModel() {
		return  HomeViewModel();
	}

	@override
	Widget buildView(BuildContext context, LayoutInformation layoutInformation, HomeViewModel model) {
		final  String title = layoutInformation.translations['home_title'] ??  'Default Title';

		return  Scaffold(
			appBar:  AppBar(
				title:  Text(title),
			),
			body:  Container(
			width:  double.infinity,
			child:  Column(
				mainAxisAlignment:  MainAxisAlignment.center,
				children:  <Widget>[
					MaterialButton(
						child:  const  Text('Say Hello From Home'),
						onPressed: () async  => dispatchEvent(context, model, PresentDialogEvent(false, false)),
					),
					MaterialButton(
						child:  const  Text('Say Hello From Middleware'),
						onPressed: () async  => dispatchEvent(context, model, PresentDialogEvent(true, false)),	
					),
					MaterialButton(
						child:  const  Text('Throw exception'),
						onPressed: () async  => dispatchEvent(context, model, PresentDialogEvent(true, true)),
					),
					],
				),
			),
		);
	}
}
```
### Example ViewModel
```dart
class  HomeViewModel  extends  EventViewModel {
	@override
	Future<void> handleEvent(BuildContext context, Event event) async {
		switch (event.runtimeType) {
			case  PresentDialogEvent:
				await sayHello(context);
				break;
			default:
				print('Unknown event: ${event.runtimeType}');
				break;
			}
		}

Map<Locale, Map<String, String>> translations = {
  Locale('en'): {
    'view_title': 'Example Title',
    'view_raise_event': 'Raise Event',
  },
  Locale('hi'): {
    'view_title': 'उदाहरण शीर्षक',
    'view_raise_event': 'घटना को बढ़ाएँ',
  },
};
```
### Example Event
```dart
class View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ViewModel>(
      model: ViewModel(),
      onEventOccured: (BuildContext context, ViewModel model, dynamic event) {
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
### Example Event Middleware
```dart
class  DialogMiddleware  extends  EventMiddleware<PresentDialogEvent> {

	@override
	Future<void> handleEvent(BuildContext context, Widget sender, PresentDialogEvent t) async {
		if (t.throwException) {
			throw  Exception('Sample exception');
		}

		await showDialog<HelloDialog>(context: context, builder: (BuildContext context) =>  const  HelloDialog(sender:  'Middleware'));
	}

	@override
	Future<bool> shouldAbsorb(BuildContext context, Widget sender, PresentDialogEvent t) async {
		return true;
	}

	@override
	Future<bool> shouldHandle(BuildContext context, Widget sender, PresentDialogEvent t) async {
		return sender is  HomeView  && t.intercept;
	}
}
```
### Example Error Middleware
```dart
class ViewModel extends BaseViewModel {
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
Any questions?
Fire them over on Github or Facebook!

- Ryan