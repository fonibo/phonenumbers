import 'package:flutter/widgets.dart';

import 'country.dart';
import 'phonenumber.dart';

class PhoneNumberEditingController extends ValueNotifier<PhoneNumber> {
  PhoneNumberEditingController([PhoneNumber value = PhoneNumber.empty])
      : nationalNumberController =
            TextEditingController(text: value.nationalNumber),
        countryListener = ValueNotifier(value.country),
        super(value) {
    _initialize();
  }

  PhoneNumberEditingController.country(Country country)
      : assert(country != null),
        nationalNumberController = TextEditingController(),
        countryListener = ValueNotifier(country),
        super(PhoneNumber.empty.copyWith(country: country)) {
    _initialize();
  }

  factory PhoneNumberEditingController.countryCode(String countryCode) =>
      PhoneNumberEditingController.country(Country.fromCode(countryCode));

  final TextEditingController nationalNumberController;
  final ValueNotifier<Country> countryListener;

  Country get country => countryListener.value;

  set country(Country newValue) {
    countryListener.value = newValue;
  }

  String get nationalNumber => nationalNumberController.text;

  set nationalNumber(String newValue) {
    nationalNumberController.text = newValue;
  }

  @override
  void dispose() {
    countryListener.removeListener(_onChange);
    countryListener.dispose();
    nationalNumberController.removeListener(_onChange);
    nationalNumberController.dispose();
    super.dispose();
  }

  void _initialize() {
    countryListener.addListener(_onChange);
    nationalNumberController.addListener(_onChange);
  }

  void _onChange() {
    value = PhoneNumber(country, nationalNumber);
  }
}
