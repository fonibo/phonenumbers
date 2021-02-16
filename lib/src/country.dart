abstract class LengthRule {
  factory LengthRule.range(int min, int max) => _RangeLengthRule(min, max);
  factory LengthRule.exact(int length) => _ExactLengthRule(length);
  factory LengthRule.oneOf(List<int> items) => _OneOfLengthRule(items);

  bool test(int value);
}

class _RangeLengthRule implements LengthRule {
  const _RangeLengthRule(this.min, this.max) : assert(max > min);

  final int min;
  final int max;

  @override
  bool test(int value) => value >= min && value <= max;
}

class _OneOfLengthRule implements LengthRule {
  const _OneOfLengthRule(this.items) : assert(items.length > 0);

  final List<int> items;

  @override
  bool test(int value) => items.contains(value);
}

class _ExactLengthRule implements LengthRule {
  const _ExactLengthRule(this.length);

  final int length;

  @override
  bool test(int value) => length == value;
}

class Country {
  Country(this.name, this.code, this.prefix, this.length);

  final String name;
  final String code;
  final int prefix;
  final LengthRule length;
}
