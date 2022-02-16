import 'package:phonenumbers_core/core.dart';
import 'package:test/test.dart';

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

    test('.country', () {
      expect(PhoneNumber.parse('+99455777').country!.code, 'AZ');
      expect(PhoneNumber.parse('+4345555').country!.code, 'AT');
    });

    test('.nationalNumber', () {
      expect(PhoneNumber.parse('+38612345678').nationalNumber, '12345678');
      expect(PhoneNumber.parse('+13456789').nationalNumber, '3456789');
    });

    test('.formattedNumber', () {
      expect(
        PhoneNumber.parse('994 11-2345676').formattedNumber,
        '+994112345676',
      );
    });

    test('instances should be equal', () {
      final _tNumber = PhoneNumber.parse('994 11-2345676');

      expect(
        _tNumber,
        PhoneNumber.parse('994 11-2345676'),
      );
    });

    test('instances should not be equal', () {
      final _tNumber = PhoneNumber.parse('994 11-2345675');

      expect(
        _tNumber,
        isNot(PhoneNumber.parse('994 11-2345676')),
      );
    });
  });
}
