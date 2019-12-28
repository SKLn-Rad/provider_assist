## [2.0.1] - 29/12/2019
* Fix broken readme from merge

## [2.0.0] - 29/12/2019
* Migrate to provider version 4
* Wrap common functions in singlton ProviderAssist class. All previous global functions will be found there, for example registerTranslations.
* Pass metadata in events
* Events and Errors replaced with just Events. As errors are a type of event it seems redundant to have both of these fields
* Events are now of type dynamic, this means you can pass complex classes down now instead (for example, including metadata)

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
