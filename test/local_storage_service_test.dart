import 'package:car_detection/data/local/local_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<LocalStorageService> createStorage([
    Map<String, Object> initialValues = const {},
  ]) async {
    SharedPreferences.setMockInitialValues(initialValues);
    return LocalStorageService.create();
  }

  test('onboarding defaults to false', () async {
    final storage = await createStorage();

    expect(storage.isOnboardingCompleted(), isFalse);
  });

  test('onboarding completion can be saved and restored', () async {
    final storage = await createStorage();
    await storage.setOnboardingCompleted(true);
    final restoredStorage = await LocalStorageService.create();

    expect(restoredStorage.isOnboardingCompleted(), isTrue);
  });

  test('language defaults to English', () async {
    final storage = await createStorage();

    expect(storage.getLanguage(), 'en');
  });

  test('language can be saved and restored', () async {
    final storage = await createStorage();
    await storage.setLanguage('km');
    final restoredStorage = await LocalStorageService.create();

    expect(restoredStorage.getLanguage(), 'km');
  });

  test('unsupported language values use the English default', () async {
    final storage = await createStorage({'language': 'fr'});

    expect(storage.getLanguage(), 'en');
  });

  test('notification read IDs default to an empty set', () async {
    final storage = await createStorage();

    expect(storage.getReadNotificationIds(), isEmpty);
  });

  test('notification read IDs can be saved and restored', () async {
    final storage = await createStorage();
    await storage.saveReadNotificationIds({4, 1, 3});
    final restoredStorage = await LocalStorageService.create();

    expect(restoredStorage.getReadNotificationIds(), {1, 3, 4});
  });

  test('invalid stored notification IDs are ignored safely', () async {
    final storage = await createStorage({
      'read_notification_ids': ['1', 'invalid', '3'],
    });

    expect(storage.getReadNotificationIds(), {1, 3});
  });

  test('session phone can be saved and cleared', () async {
    final storage = await createStorage();
    await storage.setSessionPhone('12345678');
    final restoredStorage = await LocalStorageService.create();

    expect(restoredStorage.getSessionPhone(), '12345678');

    await restoredStorage.clearSessionPhone();
    expect(restoredStorage.getSessionPhone(), isNull);
  });

  test('notification preference defaults and persists', () async {
    final storage = await createStorage();

    expect(
      storage.getNotificationPreference(
        'Payment reminders',
        defaultValue: true,
      ),
      isTrue,
    );

    await storage.setNotificationPreference('Payment reminders', false);
    final restoredStorage = await LocalStorageService.create();

    expect(
      restoredStorage.getNotificationPreference(
        'Payment reminders',
        defaultValue: true,
      ),
      isFalse,
    );
  });

  test('clear removes all local preferences', () async {
    final storage = await createStorage();
    await storage.setOnboardingCompleted(true);
    await storage.setLanguage('km');
    await storage.saveReadNotificationIds({1, 2});
    await storage.setSessionPhone('12345678');
    await storage.setNotificationPreference('Payment reminders', false);

    await storage.clearLocalPreferences();

    expect(storage.isOnboardingCompleted(), isFalse);
    expect(storage.getLanguage(), 'en');
    expect(storage.getReadNotificationIds(), isEmpty);
    expect(storage.getSessionPhone(), isNull);
    expect(
      storage.getNotificationPreference(
        'Payment reminders',
        defaultValue: true,
      ),
      isTrue,
    );
  });
}
