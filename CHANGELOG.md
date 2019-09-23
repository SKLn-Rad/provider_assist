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
