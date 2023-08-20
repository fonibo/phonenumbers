## 1.1.1

### Features

- Dart SDK 3.x.y support
- Replaced `theme.accentColor` with `theme.colorScheme.secondary` - [#9](https://github.com/fonibo/phonenumbers/pull/9)

## 1.1.0

### Features

- Core functionalities like parsing & formatting moved to separate package: [`package:phonenumbers_core/core.dart`](https://pub.dev/packages/phonenumbers_core).
- Added `prefixBuilder` property to `PhoneNumberField`
- Added `dialogTitle` property to `PhoneNumberField`

### Breaking

- Removed `phonenumbers_countries` library and moved to separate package: [`package:phonenumbers_core/data.dart`](https://pub.dev/packages/phonenumbers_core).

## 1.0.2

### Fixes

- Fixed phone number database entry for 994

## 1.0.1

### Fixes

- Static analyzer issues fixed

### Features

- Updated dialog title to "Choose a Country / Region"

## 1.0.0

### Fixes

- Migration to null-safety

## 0.0.8

### Fixes

- Fixed `nationalNumber` and `formattedNumber` parsing

## Testing

- Added more unit tests for `PhoneNumber` class

## 0.0.7

### Fixes

- Validate when initial value is provided

## 0.0.6

### Features

- Added `PhoneNumberFormField` widget
- Error and helper text displayment fixed

## 0.0.5

### Fixes

- Fixed phone number parsing

## 0.0.4

### Features

- Added inline documentation for the public API.

### Fixes

- Update country and national number controllers when updating value

## 0.0.3

## Features

- Added `countryCodeWidth` property

## 0.0.2

### Fixes

- Fix screenshot URLs

## 0.0.1

### Features

- Initial release
