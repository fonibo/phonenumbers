# phonenumbers

Phone number validation and filed written in pure dart without any native dependency.

| ![](https://i.imgur.com/bADKfYM.png) | ![](https://i.imgur.com/xasmErW.png) |
| ------------------------------------ | ------------------------------------ |

## Package Status

> ⛔️ **The package is not production ready.**\
> There might be some breaking changes over time, we'll try not to break too much but keep that in your mind.

## Why...?

There's currently lots of phone number packages available in [pub.dev](https://pub.dev).
But most of them uses platform channels to use native phone number library implementations
like Google's LibPhonenumber. But adding additional abstraction layer (messaging channel
between flutter and native code) increases complexity and creates another surface for point
of failture. Also lots of exists libraries have lack of customizability features.

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
