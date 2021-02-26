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

  static const empty = PhoneNumber._(
    country: null,
    nationalNumber: '',
    formattedNumber: '',
    isValid: false,
  );

  /// Phone number country
  final Country country;

  /// National number part of the phone number
  final String nationalNumber;

  /// E.164 formatted phone number
  final String formattedNumber;

  /// Stores whether or not the phone number is valid
  final bool isValid;

  /// Normalize [number] by removing additional symbols
  static String normalize(String number) {
    return number.split('').where((c) => int.tryParse(c) != null).join();
  }

  /// Create [PhoneNumber] instance using given [country] and [nationalNumber]
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

  /// Create [PhoneNumber] instance using country found by given [countryCode]
  /// and [nationalNumber]
  factory PhoneNumber.countryCode(String countryCode, String nationalNumber) {
    ArgumentError.checkNotNull(countryCode, 'countryCode');

    return PhoneNumber(Country.fromCode(countryCode), nationalNumber);
  }

  /// Parse given [value] into [PhoneNumber] instance
  factory PhoneNumber.parse(String value) {
    ArgumentError.checkNotNull(value, 'value');

    final normalizedValue = normalize(value);
    final matchedCountries = countries.where((c) => c.matches(normalizedValue));

    for (var item in matchedCountries) {
      if (item.isValidNumber(normalizedValue)) {
        return PhoneNumber._(
          nationalNumber: normalizedValue.substring(item.prefixLength),
          formattedNumber: '+$normalizedValue',
          country: item,
          isValid: true,
        );
      }
    }

    if (matchedCountries.isNotEmpty) {
      return PhoneNumber._(
        country: matchedCountries.first,
        nationalNumber:
            normalizedValue.substring(matchedCountries.first.prefixLength),
        formattedNumber: '+$normalizedValue',
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

  @override
  String toString() => formattedNumber;

  /// Create new [PhoneNumber] instance by modifying
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
}
