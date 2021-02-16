import 'package:flutter/foundation.dart';

import 'country.dart';
import 'data.dart';

@immutable
class PhoneNumber {
  const PhoneNumber._({
    this.country,
    this.nationalNumber,
    this.formattedNumber,
    this.isValid,
  });

  final Country country;
  final String nationalNumber;
  final String formattedNumber;
  final bool isValid;

  static const empty = PhoneNumber._(
    country: null,
    nationalNumber: '',
    formattedNumber: '',
    isValid: false,
  );

  @override
  String toString() => formattedNumber;

  PhoneNumber copyWith({
    Country country,
    String nationalNumber,
    String formattedNumber,
    bool isValid,
  }) =>
      PhoneNumber._(
        country: country ?? this.country,
        nationalNumber: nationalNumber ?? this.nationalNumber,
        formattedNumber: formattedNumber ?? this.formattedNumber,
        isValid: isValid ?? this.isValid,
      );

  static String normalize(String number) {
    return number.split('').where((c) => int.tryParse(c) != null).join();
  }

  factory PhoneNumber(Country country, String nationalNumber) {
    ArgumentError.checkNotNull(country, 'country');
    ArgumentError.checkNotNull(nationalNumber, 'nationalNumber');

    final normalizedNationalNumber = normalize(nationalNumber);

    return PhoneNumber._(
      country: country,
      nationalNumber: normalizedNationalNumber,
      formattedNumber: '+${country.prefix}$normalizedNationalNumber',
      isValid: country.isValidNationalNumber(normalizedNationalNumber),
    );
  }

  factory PhoneNumber.countryCode(String countryCode, String nationalNumber) {
    ArgumentError.checkNotNull(countryCode, 'countryCode');

    return PhoneNumber(Country.fromCode(countryCode), nationalNumber);
  }

  factory PhoneNumber.parse(String value) {
    ArgumentError.checkNotNull(value, 'value');

    final normalizedValue = normalize(value);
    final matchedCountries = countries.where((c) => c.matches(value)).toList();

    for (var item in matchedCountries) {
      if (item.isValidNumber(normalizedValue)) {
        return PhoneNumber._(
          nationalNumber: normalizedValue.substring(item.prefixLength),
          formattedNumber: '+${item.prefix}$normalizedValue',
          country: item,
          isValid: true,
        );
      }
    }

    if (matchedCountries.isNotEmpty) {
      return PhoneNumber._(
        country: matchedCountries.first,
        nationalNumber: normalizedValue,
        formattedNumber: '+${matchedCountries.first.prefix}$normalizedValue',
        isValid: false,
      );
    }

    return PhoneNumber._(
      country: null,
      nationalNumber: normalizedValue,
      formattedNumber: '+$normalizedValue',
      isValid: false,
    );
  }
}
