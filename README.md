
#  Provider Assist

Provider assist is a ton of helpful tools designed to improve development within Flutter even further!

This project is a brainchild of mine and is the core of any flutter application I personally develop. It serves these purposes:

* Remove common boilerplate which is written each time I start a new application
* Be simple enough for me to use it to train non-dart developers to start building their own application
* Enforces best practice and consistency across my projects

Out of the box, these are the core features (for now):
* Provides a basic MVVM state management system based on top of provider inspired by other frameworks (Bloc, Prism, Redux)
* Provides localization out of the box
* Provides common device information in each build function without the need for MediaQuery (Device Type, Screen Size, Safe Padding, etc)

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
final LayoutInformation layout = LayoutInformation(context);
```

##  State Management
State management in provider assist is meant to be easy to pick up and have elements of other common frameworks to more easily onboard new Flutter developers.

At its core, it is an MVVM style framework, which fires events from the view via dispatchEvent in order to be processed.

Unlike pure provider, it uncouples the View from the ViewModel and allows for easy testing of each component one at a time.

This also means you can have middleware between the view and its state, like redux. (Just with less boilerplate, many thanks to AsyncRedux for its inspiration)

Note: You MUST still call notifyListeners in your ViewModel to update the View

### Middleware
Note: Middleware is executed in order of how they are placed into the list in ProviderAssist

* EventMiddleware
Occurs before the event is passed to the view and can be used to catch common events to prevent rewriting the same code multiple times

* ErrorMiddleware
Catches errors which occur in the EventMiddleware or the Event itself, this like above means errors can be handled either in the view or globally.

![Flow Diagram](https://i.ibb.co/k4rc4Vv/Untitled.png "Flow Diagram")

## In Code
### Above your MaterialApp
```dart
class App extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return ProviderAssist(
			localizations:  Localization.translations,
			eventMiddleware:  <EventMiddleware<Event>>[
				DialogMiddleware(),
			],
			errorMiddleware:  <ErrorMiddleware>[
				UnknownErrorMiddleware(),
			],
			child:  MaterialApp(
				locale:  const  Locale('en'),
				// locale: const Locale('hi'),
				supportedLocales:  const  <Locale>[
					Locale('en'),
					Locale('hi'),
				],
				localizationsDelegates:  const  <LocalizationsDelegate>[
					GlobalMaterialLocalizations.delegate,
					GlobalWidgetsLocalizations.delegate,
				],
				home:  HomeView(),
			),
		);
	}
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

	Future<void> sayHello(BuildContext context) async {
		await showDialog<HelloDialog>(context: context, builder: (BuildContext context) =>  const  HelloDialog(sender:  'Home View'));
		notifyListeners();
	}
}
```
### Example Event
```dart
class  PresentDialogEvent  extends  Event {
	PresentDialogEvent(this.intercept, this.throwException);
	final  bool intercept;
	final  bool throwException;
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
class  UnknownErrorMiddleware  extends  ErrorMiddleware {
	@override
	Future<void> handleEvent(BuildContext context, Widget sender, Object error) async {
		final  Exception ex = error as  Exception;
		await showDialog<ErrorDialog>(context: context, builder: (BuildContext context) =>  ErrorDialog(error: ex));
	}

	@override
	Future<bool> shouldAbsorb(BuildContext context, Widget sender, Object error) async {
		return  true;
	}

	@override
	Future<bool> shouldHandle(BuildContext context, Widget sender, Object error) async {
		return error is  Exception;
	}
}
```
Any questions?
Fire them over on Github or Facebook!

- Ryan