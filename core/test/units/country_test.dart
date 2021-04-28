import 'package:phonenumbers_core/core.dart';
import 'package:test/test.dart';

void main() {
  group('Country', () {
    test('.fromCode()', () {
      expect(Country.fromCode('AZ').code, 'AZ');
      expect(Country.fromCode('TR').prefix, 90);
    });

    test('.matches()', () {
      expect(Country.fromCode('AZ').matches('994556667788'), true);
      expect(Country.fromCode('AZ').matches('455324234344'), false);
      expect(Country.fromCode('AZ').matches('994'), true);
    });
  });
}
