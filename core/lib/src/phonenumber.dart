import 'package:quiver/core.dart';

import 'country.dart';
import 'data.dart';

class PhoneNumber {
  /// Create [PhoneNumber] instance using given [country] and [nationalNumber]
  factory PhoneNumber(Country? country, String? nationalNumber) {
    if (country == null && nationalNumber == null) {
      return empty.clone();
    }

    final String normalizedNationalNumber = normalize(nationalNumber ?? '');

    return PhoneNumber._(
      country: country,
      nationalNumber: normalizedNationalNumber,
      formattedNumber: country == null
          ? normalizedNationalNumber
          : '+${country.prefix}$normalizedNationalNumber',
      isValid:
          country?.isValidNationalNumber(normalizedNationalNumber) ?? false,
    );
  }

  /// Create [PhoneNumber] instance using country found by given [countryCode]
  /// and [nationalNumber]
  @Deprecated('Use `PhoneNumber.isoCode` instead')
  factory PhoneNumber.countryCode(String countryCode, String nationalNumber) {
    return PhoneNumber(Country.fromCode(countryCode), nationalNumber);
  }

  /// Create [PhoneNumber] instance using country found by given [isoCode]
  /// and [nationalNumber]
  factory PhoneNumber.isoCode(String isoCode, String nationalNumber) {
    return PhoneNumber(Country.fromCode(isoCode), nationalNumber);
  }

  /// Parse given [value] into [PhoneNumber] instance
  factory PhoneNumber.parse(String value) {
    final String normalizedValue = normalize(value);
    final Iterable<Country> matchedCountries =
        countries.where((c) => c.matches(normalizedValue));

    for (final item in matchedCountries) {
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

  const PhoneNumber._({
    this.country,
    required this.nationalNumber,
    required this.formattedNumber,
    required this.isValid,
  });

  static const PhoneNumber empty = PhoneNumber._(
    country: null,
    isValid: false,
    nationalNumber: '',
    formattedNumber: '',
  );

  /// Normalize [number] by removing additional symbols
  static String normalize(String number) {
    return number.split('').where((c) => int.tryParse(c) != null).join();
  }

  /// Phone number country
  final Country? country;

  /// National number part of the phone number
  final String nationalNumber;

  /// E.164 formatted phone number
  final String formattedNumber;

  /// Stores whether or not the phone number is valid
  final bool isValid;

  @override
  String toString() => formattedNumber;

  /// Create new [PhoneNumber] instance by modifying
  PhoneNumber copyWith({
    Country? country,
    String? nationalNumber,
    String? formattedNumber,
    bool? isValid,
  }) =>
      PhoneNumber._(
        country: country ?? this.country,
        nationalNumber: nationalNumber ?? this.nationalNumber,
        formattedNumber: formattedNumber ?? this.formattedNumber,
        isValid: isValid ?? this.isValid,
      );

  /// Create exact same clone of this [PhoneNumber] instance.
  PhoneNumber clone() => PhoneNumber._(
        isValid: isValid,
        country: country,
        nationalNumber: nationalNumber,
        formattedNumber: formattedNumber,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            other is PhoneNumber &&
            other.country == country &&
            other.formattedNumber == formattedNumber &&
            other.isValid == isValid &&
            other.nationalNumber == nationalNumber);
  }

  @override
  int get hashCode => hashObjects(
        [
          country,
          formattedNumber,
          isValid,
          nationalNumber,
        ],
      );
}
