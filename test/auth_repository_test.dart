import 'package:car_detection/data/auth/auth_user.dart';
import 'package:car_detection/data/auth/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('phone normalization', () {
    test('removes the local trunk zero', () {
      expect(normalizePhone('012345678'), '12345678');
    });

    test('removes the +855 country code', () {
      expect(normalizePhone('+855 12 345 678'), '12345678');
    });

    test('formats the local number for display', () {
      expect(formatPhone('012345678'), '12 345 678');
    });
  });

  group('test user repository', () {
    const repository = TestUserRepository();

    test('finds the test user by normalized phone', () async {
      final user = await repository.findByPhone('012345678');

      expect(user?.phone, '12345678');
      expect(user?.fullName, 'Sophea Vann');
      expect(user?.email, 'sophea.vann@example.com');
    });

    test('rejects an unknown phone', () async {
      expect(await repository.findByPhone('99999999'), isNull);
    });

    test('accepts the configured test code', () async {
      final user = await repository.verifyCode('12345678', '123456');

      expect(user?.fullName, 'Sophea Vann');
    });

    test('rejects an invalid code', () async {
      expect(await repository.verifyCode('12345678', '000000'), isNull);
    });
  });
}
