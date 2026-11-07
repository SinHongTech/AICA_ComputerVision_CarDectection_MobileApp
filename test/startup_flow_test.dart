import 'dart:async';

import 'package:car_detection/UI/app_shell.dart';
import 'package:car_detection/UI/onboarding_screen.dart';
import 'package:car_detection/UI/sign_in_screen.dart';
import 'package:car_detection/UI/splash_screen.dart';
import 'package:car_detection/data/demo_store.dart';
import 'package:car_detection/data/local/local_storage_service.dart';
import 'package:car_detection/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    demoStore.reset();
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('first launch shows splash, onboarding, then saves completion', (
    tester,
  ) async {
    final storage = await LocalStorageService.create();
    await tester.pumpWidget(
      SmartTrafficApp(storageFactory: () async => storage),
    );

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(OnboardingScreen), findsNothing);
    await tester.pumpAndSettle();
    expect(find.byType(OnboardingScreen), findsOneWidget);

    for (var i = 0; i < 2; i++) {
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    expect(storage.isOnboardingCompleted(), isTrue);
    expect(find.byType(SignInScreen), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    demoStore.reset();
    await tester.pumpWidget(
      SmartTrafficApp(storageFactory: () async => storage),
    );
    expect(find.byType(SplashScreen), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(SignInScreen), findsOneWidget);
  });

  testWidgets('saved test session opens the app shell', (tester) async {
    final storage = await LocalStorageService.create();
    await storage.setOnboardingCompleted(true);
    await storage.setSessionPhone('12345678');

    await tester.pumpWidget(
      SmartTrafficApp(storageFactory: () async => storage),
    );

    expect(find.byType(SplashScreen), findsOneWidget);
    await tester.pumpAndSettle();

    expect(find.byType(AppShell), findsOneWidget);
    expect(demoStore.isSignedIn, isTrue);
    expect(demoStore.phone, '12 345 678');
  });

  testWidgets('unknown saved session falls back to sign in', (tester) async {
    final storage = await LocalStorageService.create();
    await storage.setOnboardingCompleted(true);
    await storage.setSessionPhone('99999999');

    await tester.pumpWidget(
      SmartTrafficApp(storageFactory: () async => storage),
    );
    for (var i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 200));
      if (find.byType(SignInScreen).evaluate().isNotEmpty) break;
    }

    expect(find.byType(SignInScreen), findsOneWidget);
    expect(demoStore.isSignedIn, isFalse);
    expect(storage.getSessionPhone(), isNull);
  });

  testWidgets(
    'debug reset restores onboarding and preserves other preferences',
    (tester) async {
      final storage = await LocalStorageService.create();
      await storage.setOnboardingCompleted(true);
      await storage.setLanguage('km');
      await storage.setDarkMode(true);
      await storage.saveReadNotificationIds({2, 5});

      await tester.pumpWidget(
        SmartTrafficApp(
          storageFactory: () async => storage,
          debugResetOnboarding: true,
        ),
      );
      expect(find.byType(SplashScreen), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(OnboardingScreen), findsOneWidget);
      expect(storage.isOnboardingCompleted(), isFalse);
      expect(storage.getLanguage(), 'km');
      expect(storage.isDarkMode(), isTrue);
      expect(storage.getReadNotificationIds(), {2, 5});

      await tester.tap(find.text('រំលង'));
      await tester.pumpAndSettle();
      expect(find.byType(SignInScreen), findsOneWidget);
      expect(storage.isOnboardingCompleted(), isTrue);

      await tester.pumpWidget(const SizedBox());
      demoStore.reset();
      await tester.pumpWidget(
        SmartTrafficApp(storageFactory: () async => storage),
      );
      expect(find.byType(SplashScreen), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(SignInScreen), findsOneWidget);
      expect(find.byType(OnboardingScreen), findsNothing);
    },
  );

  testWidgets('splash waits for preferences before navigating', (tester) async {
    final pendingStorage = Completer<LocalStorageService>();
    await tester.pumpWidget(
      SmartTrafficApp(storageFactory: () => pendingStorage.future),
    );

    await tester.pump(const Duration(seconds: 2));
    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(SignInScreen), findsNothing);
    expect(find.byType(OnboardingScreen), findsNothing);

    final storage = await LocalStorageService.create();
    await storage.setOnboardingCompleted(true);
    pendingStorage.complete(storage);
    await tester.pumpAndSettle();
    expect(find.byType(SignInScreen), findsOneWidget);
  });
}
