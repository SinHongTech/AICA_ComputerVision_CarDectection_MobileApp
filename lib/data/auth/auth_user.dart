/// A user record supplied by the temporary test user repository.
class AuthUser {
  const AuthUser({
    required this.phone,
    required this.fullName,
    required this.email,
  });

  /// Normalized Cambodian local number: 8 digits, without trunk `0` or `855`.
  final String phone;
  final String fullName;
  final String email;
}

/// Normalizes `012345678`, `85512345678`, and `12345678` to `12345678`.
String normalizePhone(String value) {
  var digits = value.replaceAll(RegExp(r'\D'), '');
  if (digits.startsWith('855') && digits.length == 11) {
    digits = digits.substring(3);
  }
  if (digits.length == 9 && digits.startsWith('0')) {
    digits = digits.substring(1);
  }
  return digits;
}

/// Formats an 8-digit Cambodian local number as `12 345 678`.
String formatPhone(String value) {
  final digits = normalizePhone(value);
  if (digits.length != 8) return digits;
  return '${digits.substring(0, 2)} ${digits.substring(2, 5)} '
      '${digits.substring(5)}';
}
