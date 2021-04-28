import 'dart:math';

import 'package:quiver/core.dart';

import 'data.dart';

/// Defines length rules for phone numbers for specific country.
abstract class LengthRule {
  factory LengthRule.range(int min, int max) => _RangeLengthRule(min, max);
  factory LengthRule.exact(int length) => _ExactLengthRule(length);
  factory LengthRule.oneOf(List<int> items) => _OneOfLengthRule(items);

  bool test(int value);
  int get maxLength;
}

/// Holds country related data for phone numbers.
class Country {
  Country(this.name, this.code, this.prefix, this.length)
      : _prefixStr = prefix.toString(),
        prefixLength = prefix.toString().length;

  /// Returns [Country] instance using [isoCode].
  static Country fromCode(String isoCode) {
    isoCode = isoCode.toUpperCase();
    return countries.firstWhere((c) => c.code == isoCode);
  }

  /// Country name
  final String name;

  /// Country 2 char alpha code
  final String code;

  /// Country calling prefix code
  final int prefix;

  /// Length of the [prefix]
  final int prefixLength;

  /// Length rule for national number
  final LengthRule length;

  final String _prefixStr;

  /// Does given [normalizedNumber] matches this country.
  bool matches(String normalizedNumber) =>
      normalizedNumber.startsWith(_prefixStr);

  /// Validates given [nationalNumber] using defined [length] rule.
  bool isValidNationalNumber(String nationalNumber) =>
      length.test(nationalNumber.length);

  /// Checks whether or not given [normalizedNumber] is valid phone number in
  /// this country.
  bool isValidNumber(String normalizedNumber) =>
      matches(normalizedNumber) &&
      length.test(normalizedNumber.length - _prefixStr.length);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            other is Country &&
            other.name == name &&
            other.code == code &&
            other.prefix == prefix &&
            other.length == length);
  }

  @override
  int get hashCode => hashObjects([name, code, prefix, length]);
}

class _RangeLengthRule implements LengthRule {
  const _RangeLengthRule(this.min, this.max) : assert(max > min);

  final int min;
  final int max;

  @override
  bool test(int value) => value >= min && value <= max;

  @override
  int get maxLength => max;

  @override
  int get hashCode => hash2(min, max);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            other is _RangeLengthRule &&
            other.max == max &&
            other.min == min);
  }
}

class _OneOfLengthRule implements LengthRule {
  const _OneOfLengthRule(this.items) : assert(items.length > 0);

  final List<int> items;

  @override
  bool test(int value) => items.contains(value);

  @override
  int get maxLength => items.reduce(max);

  @override
  int get hashCode => hashObjects(items);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType == other.runtimeType && other is _OneOfLengthRule) {
      if (items.length != other.items.length) return false;
      for (var i = 0; i < items.length; i++) {
        if (items[i] != other.items[i]) return false;
      }
      return true;
    }
    return false;
  }
}

class _ExactLengthRule implements LengthRule {
  const _ExactLengthRule(this.length);

  final int length;

  @override
  bool test(int value) => length == value;

  @override
  int get maxLength => length;

  @override
  int get hashCode => length;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            other is _ExactLengthRule &&
            other.length == length);
  }
}
