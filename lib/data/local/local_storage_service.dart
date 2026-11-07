import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  const LocalStorageService._(this._preferences);

  static const _onboardingKey = 'has_completed_onboarding';
  static const _darkModeKey = 'is_dark_mode';
  static const _languageKey = 'language';
  static const _readNotificationIdsKey = 'read_notification_ids';
  static const _sessionPhoneKey = 'session_phone';
  static const _notificationPreferencePrefix = 'notification_preference_';

  final SharedPreferences? _preferences;

  static Future<LocalStorageService> create() async {
    try {
      return LocalStorageService._(await SharedPreferences.getInstance());
    } catch (_) {
      return const LocalStorageService._(null);
    }
  }

  bool isOnboardingCompleted() {
    try {
      return _preferences?.getBool(_onboardingKey) ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<void> setOnboardingCompleted(bool value) async {
    try {
      await _preferences?.setBool(_onboardingKey, value);
    } catch (_) {
      // The app can continue with its in-memory state if storage is unavailable.
    }
  }

  String getLanguage() {
    try {
      final language = _preferences?.getString(_languageKey);
      return language == 'km' ? 'km' : 'en';
    } catch (_) {
      return 'en';
    }
  }

  Future<void> setLanguage(String language) async {
    final safeLanguage = language == 'km' ? 'km' : 'en';
    try {
      await _preferences?.setString(_languageKey, safeLanguage);
    } catch (_) {
      // The app can continue with its in-memory state if storage is unavailable.
    }
  }

  bool isDarkMode() {
    try {
      return _preferences?.getBool(_darkModeKey) ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<void> setDarkMode(bool value) async {
    try {
      await _preferences?.setBool(_darkModeKey, value);
    } catch (_) {
      // Continue with the current in-memory theme if storage is unavailable.
    }
  }

  Set<int> getReadNotificationIds() {
    try {
      final storedIds = _preferences?.getStringList(_readNotificationIdsKey);
      if (storedIds == null) return {};
      return storedIds.map(int.tryParse).whereType<int>().toSet();
    } catch (_) {
      return {};
    }
  }

  Future<void> saveReadNotificationIds(Set<int> ids) async {
    final sortedIds = ids.toList()..sort();
    try {
      await _preferences?.setStringList(
        _readNotificationIdsKey,
        sortedIds.map((id) => id.toString()).toList(),
      );
    } catch (_) {
      // The app can continue with its in-memory state if storage is unavailable.
    }
  }

  String? getSessionPhone() {
    try {
      final phone = _preferences?.getString(_sessionPhoneKey);
      return phone == null || phone.isEmpty ? null : phone;
    } catch (_) {
      return null;
    }
  }

  Future<void> setSessionPhone(String phone) async {
    try {
      await _preferences?.setString(_sessionPhoneKey, phone);
    } catch (_) {
      // The session can continue in memory if storage is unavailable.
    }
  }

  Future<void> clearSessionPhone() async {
    try {
      await _preferences?.remove(_sessionPhoneKey);
    } catch (_) {
      // Safe defaults will be used the next time the app starts.
    }
  }

  bool getNotificationPreference(String key, {required bool defaultValue}) {
    try {
      return _preferences?.getBool('$_notificationPreferencePrefix$key') ??
          defaultValue;
    } catch (_) {
      return defaultValue;
    }
  }

  Future<void> setNotificationPreference(String key, bool value) async {
    try {
      await _preferences?.setBool('$_notificationPreferencePrefix$key', value);
    } catch (_) {
      // Continue with the current in-memory preference.
    }
  }

  Future<void> clearNotificationPreferences() async {
    try {
      final keys = _preferences?.getKeys() ?? const <String>{};
      for (final key in keys) {
        if (key.startsWith(_notificationPreferencePrefix)) {
          await _preferences?.remove(key);
        }
      }
    } catch (_) {
      // Defaults apply when preferences cannot be read.
    }
  }

  Future<void> clearLocalPreferences() async {
    try {
      await _preferences?.remove(_onboardingKey);
      await _preferences?.remove(_languageKey);
      await _preferences?.remove(_darkModeKey);
      await _preferences?.remove(_readNotificationIdsKey);
      await _preferences?.remove(_sessionPhoneKey);
      await clearNotificationPreferences();
    } catch (_) {
      // Safe defaults will be used the next time the app starts.
    }
  }

  /// Removes only onboarding completion for a debug startup.
  Future<void> resetOnboardingForDebug() async {
    if (!kDebugMode) return;
    try {
      await _preferences?.remove(_onboardingKey);
    } catch (_) {
      // Startup can continue with the saved value if storage is unavailable.
    }
  }
}
