## [2.0.0-beta-7] - 18/11/2019
* Bounce errors back up to provider assist so that middleware can handle them even if they occur at the view level

## [2.0.0-beta-6] - 18/11/2019
* Catch exception on view handle event and throw to view handle error

## [2.0.0-beta-5] - 17/11/2019
* Make provider assist inject itself into the top level providers so it can be accessed by the users own providers to dispatch events

## [2.0.0-beta-4] - 17/11/2019
* Move event processing up to ProviderAssist so that any class may publish events given they have the instance of ProviderAssist

## [2.0.0-beta-3] - 17/11/2019
* Added BuildContext to buildModel function to allow dependency injection via the widget tree

## [2.0.0-beta-2] - 17/11/2019
* Added onViewFirstLoad to EventViewModel to allow bootstrapping of the ViewModel

## [2.0.0-beta-1] - 17/11/2019
* BaseView and BaseViewModel are now deprecated in favour of the new EventView and EventViewModel inspired by React and FlutterBloc
* Updated documentation to detail the new state management system
* Added EventMiddleware to allow global handling of events (for example, moving common dialogs outside of the view, such as internet connectivity)
* Added a new multi-provider called ProviderAssist, that when positioned in place of the top level multi-provider will allow middleware and localization

## [1.5.3] - 08/11/2019
* Fix a potential NPE when trying to create a mock for a view model

## [1.5.2] - 06/11/2019
* Fix example in documentation

## [1.5.1] - 17/09/2019
* Improve Documentation

## [1.5.0] - 17/09/2019
* BREAKING CHANGE: onEventReceived and onErrorReceived will now supply the model. You will need to ammend your code to include this!

## [1.4.1] - 20/09/2019
* Provide the current context of the consumer in layoutInformation, use this sparingly!

## [1.4.0] - 17/09/2019
* BREAKING CHANGE: onViewFirstLoad will now supply the model. You will need to ammend your code to include this!

## [1.3.2] - 17/09/2019
* Fix another small bug with event streams.

## [1.3.1] - 17/09/2019
* Fix a bug where the same stream was being listened to twice causing an assertion.

## [1.3.0] - 16/09/2019
* Added a new callback on BaseViewModel to raise events back to the UI via a string, this can be used for anything. Examples being login, navigation requests, etc.

## [1.2.0] - 13/09/2019
* Basic localization support, see example

## [1.1.0] - 10/09/2019
* (BREAKING CHANGES) Refactored the LayoutInformation passed back from the build function to be more futureproof.

## [1.0.0] - 10/09/2019
* Leverage locale in layout information, first stable release

## [0.0.2] - 09/09/2019
* Improve documentation around BaseView

## [0.0.1] - 09/09/2019
* Initial release with basic feature set
