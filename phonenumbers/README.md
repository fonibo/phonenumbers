# phonenumbers

Phone number validation and filed written in pure dart without any native dependency.

| ![](https://i.imgur.com/bADKfYM.png) | ![](https://i.imgur.com/xasmErW.png) |
| ------------------------------------ | ------------------------------------ |

## Package Status

> ⛔️ **The package is not production ready.**\
> There might be some breaking changes over time, we'll try not to break too much but keep that in your mind.

## Why...?

Currently there are lots of packages available on [pub.dev](https://pub.dev) for working
with phone numbers (inputs, validators, etc...) However, most of them are using native libraries
like [libphonenumber](https://github.com/google/libphonenumber) under the hood. While those libraries
are very well written implementations, they are not written natively for Flutter (yet). That means
flutter library maintainers are using certain communication mechanisms like platform channels or ffi
to communicate with those libraries. Additional abstraction layer of communication leads to increased
implementation complexity and increases points of failure.

This library however uses simplified dart-native implementation that doesn't require additional
communication layer and also works synchronously / meaning you are guaranteed to get near-instant
feedback (if it doesn't panic, I hope 🤞).

That said, I am not trying to convience you that this is the best phone number utility for
dart/flutter. It's just the library that got my job done during the time of writing my projects.

## Getting Started

### Installation

1. Add `phonenumbers: ^1.0.0` dependency to "pubspec.yaml" file
2. Run `[flutter] pub get` to install package
3. Drink a cup of coffee

### Enjoy

Import phonenumbers library which exports useful classes like `PhoneNumberField` widget.

```dart
import 'package:phonenumbers/phonenumbers.dart';
```

Then you can build `PhoneNumberField()` widget wherever you want. It works like any other widgets.

```dart
class _MyPageState extends State<MyPage> {
  final phoneNumberController = PhoneNumberEditingController();

  @override
  void dispose() {
    phoneNumberController.dispose(); // to save environment
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PhoneNumberField(
          controller: phoneNumberController,
          decoration: InputDecoration(),
        ),
      ],
    );
  }
}
```

_The documentation will be improved over time..._

## Contribute

Found an issue, or maybe have a brilliant idea? Maybe our data is not valid.
Feel free to contribute if you want 😊
