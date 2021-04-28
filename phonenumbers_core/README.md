## phonenumbers_core

A simple phone number parsing & validation library used by [phonenumbers](https://pub.dev/packages/phonenumbers).

**Parsing**

```dart
PhoneNumber.parse('+1847327423')
```

**Validation**

```dart
PhoneNumber.parse('+342342423').isValid
```

**Create from ISO code**

```dart
PhoneNumber.isoCode('FR', '8263723')
```

**E.164 formatting**

```dart
PhoneNumber.parse('+342342423').formattedNumber
```
