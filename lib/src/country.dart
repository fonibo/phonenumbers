import 'dart:math';

import 'package:flutter/foundation.dart';
import 'data.dart';

@immutable
abstract class LengthRule {
  factory LengthRule.range(int min, int max) => _RangeLengthRule(min, max);
  factory LengthRule.exact(int length) => _ExactLengthRule(length);
  factory LengthRule.oneOf(List<int> items) => _OneOfLengthRule(items);

  bool test(int value);
  int get maxLength;
}

@immutable
class Country {
  Country(this.name, this.code, this.prefix, this.length)
      : _prefixStr = prefix.toString(),
        prefixLength = prefix.toString().length;

  final String name;
  final String code;
  final int prefix;
  final int prefixLength;
  final LengthRule length;
  final String _prefixStr;

  bool matches(String normalizedNumber) =>
      normalizedNumber.startsWith(_prefixStr);

  bool isValidNationalNumber(String nationalNumber) =>
      length.test(nationalNumber.length);

  bool isValidNumber(String normalizedNumber) =>
      matches(normalizedNumber) &&
      length.test(normalizedNumber.length - _prefixStr.length);

  static Country fromCode(String code) {
    code = code.toUpperCase();
    return countries.firstWhere((c) => c.code == code);
  }
}

class _RangeLengthRule implements LengthRule {
  const _RangeLengthRule(this.min, this.max) : assert(max > min);

  final int min;
  final int max;

  @override
  bool test(int value) => value >= min && value <= max;

  @override
  int get maxLength => max;
}

class _OneOfLengthRule implements LengthRule {
  const _OneOfLengthRule(this.items) : assert(items.length > 0);

  final List<int> items;

  @override
  bool test(int value) => items.contains(value);

  @override
  int get maxLength => items.reduce(max);
}

class _ExactLengthRule implements LengthRule {
  const _ExactLengthRule(this.length);

  final int length;

  @override
  bool test(int value) => length == value;

  @override
  int get maxLength => length;
}
