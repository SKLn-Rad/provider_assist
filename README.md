# Provider Assist

This is a simple package used to enhance the provider package with additional features for Flutter and a standard MVVM pattern. It is still very early and is still open to suggestions.

Note: This pattern is very heavily influenced by FilledStacks Provider v3 Architecture (Thanks a lot!)

## In a nutshell
This package wraps your top level views for each page in BaseView, this widget should pass in a model which extends BaseViewModel. Once you have wrapped your view, this package will give you callbacks and metadata during build which can be used to enhance the quality of your code.

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
    
## Future Features
This is down to you! I use this on a daily basis so I will be adding features I find useful in everyday development. For example:
1) Localization
2) Globally handling errors rather than implementing on each view (for example pushing an error page)
3) Passing further data down to the widget about the system. OS, etc...

## TODO
* Write tests to improve rating
* Improve documentation and example

## Example!
### Example View
```dart
class View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ViewModel>(
      model: ViewModel(),
      onErrorOccured: (BuildContext context, String errorCode) {
        print("Got a new error: $errorCode");
      },
      builder: (BuildContext context, ViewModel vm, LayoutInformation layout) {
        print("Device type: ${layout.deviceType}");
        print("Device orientation: ${layout.orientation}");
        return Scaffold(
          backgroundColor: layout.theme.backgroundColor,
          appBar: AppBar(
            title: Text('Example'),
          ),
          body: Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: CupertinoButton(
              child: Text('Raise Error'),
              onPressed: () => vm.onButtonClicked(),
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
  void onButtonClicked() {
    try {
      setBusy(true);
      notifyError('Random error');
    } finally {
      setBusy(false);
    }
  }
}
```