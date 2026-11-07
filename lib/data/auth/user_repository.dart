import 'auth_user.dart';

abstract class UserRepository {
  Future<AuthUser?> findByPhone(String phone);

  Future<AuthUser?> verifyCode(String phone, String code);
}

/// Temporary in-app test identity while the project has no backend database.
///
/// The test phone number and verification code live here, not in the UI. This
/// is not production authentication: replace this repository with an
/// API-backed implementation and server-side OTP verification before release.
class TestUserRepository implements UserRepository {
  const TestUserRepository();

  static const AuthUser _testUser = AuthUser(
    phone: '12345678',
    fullName: 'Sophea Vann',
    email: 'sophea.vann@example.com',
  );
  static const String _verificationCode = '123456';

  @override
  Future<AuthUser?> findByPhone(String phone) async {
    return normalizePhone(phone) == _testUser.phone ? _testUser : null;
  }

  @override
  Future<AuthUser?> verifyCode(String phone, String code) async {
    final matchesPhone = normalizePhone(phone) == _testUser.phone;
    final matchesCode = code.trim() == _verificationCode;
    return matchesPhone && matchesCode ? _testUser : null;
  }
}

final UserRepository appUserRepository = const TestUserRepository();
