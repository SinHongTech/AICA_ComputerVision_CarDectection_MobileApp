import 'package:flutter/foundation.dart';

import '../model/violation.dart';
import 'demo_data.dart';
import 'local/local_storage_service.dart';

class DemoStore extends ChangeNotifier {
  LocalStorageService? _localStorage;

  String phone = '12 345 678';
  String name = 'Sophea Vann';
  String email = '';
  bool hasCompletedOnboarding = false;
  String languageCode = 'en';
  bool darkMode = false;
  final Set<String> selectedFineIds = {'speeding', 'helmet'};
  final Set<String> paidFineIds = {};
  final Set<int> readNotificationIds = {};
  final Map<String, String> appeals = {};
  final Map<String, bool> notificationPreferences = {
    'New potential violations': true,
    'Official fine confirmed': true,
    'Payment reminders': true,
    'Tips & news': false,
  };

  List<Violation> get payable => demoViolations
      .where(
        (v) =>
            v.status == ViolationStatus.confirmed &&
            !paidFineIds.contains(v.id) &&
            !appeals.containsKey(v.id),
      )
      .toList();
  int get selectedTotal => payable
      .where((v) => selectedFineIds.contains(v.id))
      .fold(0, (sum, v) => sum + v.amount);

  String get languageName => languageCode == 'km' ? 'ខ្មែរ' : 'English';

  bool get hasUnreadNotifications => List.generate(
    demoNotifications.length,
    (index) => index,
  ).any((index) => !readNotificationIds.contains(index));

  Future<void> initialize(LocalStorageService localStorage) async {
    _localStorage = localStorage;
    hasCompletedOnboarding = localStorage.isOnboardingCompleted();
    languageCode = localStorage.getLanguage();
    darkMode = localStorage.isDarkMode();
    readNotificationIds
      ..clear()
      ..addAll(localStorage.getReadNotificationIds());
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    hasCompletedOnboarding = true;
    notifyListeners();
    await _localStorage?.setOnboardingCompleted(true);
  }

  Future<void> setLanguage(String value) async {
    languageCode = value == 'km' ? 'km' : 'en';
    notifyListeners();
    await _localStorage?.setLanguage(languageCode);
  }

  void setPhone(String value) {
    var digits = value.replaceAll(RegExp(r'\D'), '');
    // Cambodian mobile numbers are 9 digits locally; drop the trunk 0 so the
    // stored value matches the +855 country code shown next to it.
    if (digits.length == 9 && digits.startsWith('0')) {
      digits = digits.substring(1);
    }
    phone = digits.length >= 8
        ? '${digits.substring(0, 2)} ${digits.substring(2, 5)} ${digits.substring(5)}'
        : value;
    notifyListeners();
  }

  void setProfile(String newName, String newEmail) {
    name = newName;
    email = newEmail;
    notifyListeners();
  }

  void toggleFine(String id) {
    selectedFineIds.contains(id)
        ? selectedFineIds.remove(id)
        : selectedFineIds.add(id);
    notifyListeners();
  }

  void clearFines() {
    selectedFineIds.clear();
    notifyListeners();
  }

  void payFines(Iterable<String> ids) {
    paidFineIds.addAll(ids);
    selectedFineIds.removeAll(ids.toSet());
    notifyListeners();
  }

  void submitAppeal(String id, String explanation) {
    appeals[id] = explanation;
    notifyListeners();
  }

  Future<void> markRead(int id) async {
    readNotificationIds.add(id);
    notifyListeners();
    await _localStorage?.saveReadNotificationIds(readNotificationIds);
  }

  Future<void> markAllRead() async {
    readNotificationIds.addAll(
      List.generate(demoNotifications.length, (index) => index),
    );
    notifyListeners();
    await _localStorage?.saveReadNotificationIds(readNotificationIds);
  }

  void setPreference(String key, bool value) {
    notificationPreferences[key] = value;
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    darkMode = value;
    notifyListeners();
    await _localStorage?.setDarkMode(value);
  }

  void reset() {
    _localStorage = null;
    phone = '12 345 678';
    name = 'Sophea Vann';
    email = '';
    hasCompletedOnboarding = false;
    languageCode = 'en';
    darkMode = false;
    selectedFineIds
      ..clear()
      ..addAll({'speeding', 'helmet'});
    paidFineIds.clear();
    readNotificationIds.clear();
    appeals.clear();
    notificationPreferences
      ..clear()
      ..addAll({
        'New potential violations': true,
        'Official fine confirmed': true,
        'Payment reminders': true,
        'Tips & news': false,
      });
    notifyListeners();
  }
}

final demoStore = DemoStore();
