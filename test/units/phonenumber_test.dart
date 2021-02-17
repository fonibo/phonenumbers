import 'package:flutter_test/flutter_test.dart';
import 'package:phonenumbers/phonenumbers.dart';

void main() {
  group('PhoneNumber', () {
    test('.normalize()', () {
      expect(PhoneNumber.normalize('+444 44 5-5556-6'), '44444555566');
      expect(PhoneNumber.normalize('+1 (555) 5666-44-55'), '155556664455');
    });

    test('.parse()', () {
      expect(PhoneNumber.parse('+994 55 666 77 88').isValid, true);
      expect(PhoneNumber.parse('994(55)566-12-33').isValid, true);
      expect(PhoneNumber.parse('9945566').isValid, false);
    });
  });
}
