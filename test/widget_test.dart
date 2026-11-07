import 'package:car_detection/UI/app_shell.dart';
import 'package:car_detection/UI/appeal_screen.dart';
import 'package:car_detection/UI/onboarding_screen.dart';
import 'package:car_detection/UI/payments_screen.dart';
import 'package:car_detection/UI/profile_screen.dart';
import 'package:car_detection/UI/sign_in_screen.dart';
import 'package:car_detection/UI/vehicles_screen.dart';
import 'package:car_detection/UI/verify_screen.dart';
import 'package:car_detection/UI/violation_detail_screen.dart';
import 'package:car_detection/UI/violations_screen.dart';
import 'package:car_detection/data/demo_data.dart';
import 'package:car_detection/data/demo_store.dart';
import 'package:car_detection/data/local/local_storage_service.dart';
import 'package:car_detection/l10n/generated/app_localizations.dart';
import 'package:car_detection/main.dart';
import 'package:car_detection/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(demoStore.reset);

  testWidgets('onboarding Next advances the PageView', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));

    expect(find.text('Smart traffic monitoring'), findsOneWidget);
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Instant violation notifications'), findsOneWidget);
  });

  testWidgets('onboarding Skip opens sign in', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final storage = await LocalStorageService.create();
    await tester.pumpWidget(
      SmartTrafficApp(storageFactory: () async => storage),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
  });

  testWidgets('sign in rejects an invalid phone number', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignInScreen()));

    await tester.enterText(find.byType(TextField), '123');
    await tester.tap(find.text('Send code'));
    await tester.pump();

    expect(find.text('Enter a valid Cambodian phone number.'), findsOneWidget);
  });

  testWidgets('OTP rejects an invalid code and accepts 123456', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: VerifyScreen(phone: '12345678')),
    );

    final otpField = tester.widget<TextField>(find.byType(TextField));
    expect(otpField.decoration?.filled, isFalse);
    expect(otpField.decoration?.enabledBorder, InputBorder.none);
    expect(otpField.decoration?.focusedBorder, InputBorder.none);

    await tester.enterText(find.byType(TextField), '000000');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Use the demo code 123456.'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '123456');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(find.text('Recent Violations & Activity'), findsOneWidget);
  });

  testWidgets('main navigation switches tabs and Back returns Home', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: AppShell()));

    await tester.tap(find.byKey(const Key('main-tab-1')));
    await tester.pumpAndSettle();
    expect(find.text('Violations'), findsWidgets);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('Recent Violations & Activity'), findsOneWidget);
  });

  testWidgets('main tabs fit a narrow Android viewport', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const MaterialApp(home: AppShell()));

    for (final (name, index) in [
      ('Violations', 1),
      ('Payments', 2),
      ('Profile', 3),
      ('Home', 0),
    ]) {
      await tester.tap(find.byKey(Key('main-tab-$index')));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: 'after selecting $name');
    }
  });

  for (final width in [320.0, 390.0, 393.0]) {
    for (final locale in ['en', 'km']) {
      for (final dark in [false, true]) {
        testWidgets(
          'Stitch Home fits $width $locale ${dark ? 'dark' : 'light'}',
          (tester) async {
            await tester.binding.setSurfaceSize(Size(width, 844));
            addTearDown(() => tester.binding.setSurfaceSize(null));
            await tester.pumpWidget(
              MaterialApp(
                locale: Locale(locale),
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                theme: buildLightTheme(),
                darkTheme: buildDarkTheme(),
                themeMode: dark ? ThemeMode.dark : ThemeMode.light,
                home: const AppShell(),
              ),
            );
            await tester.pumpAndSettle();
            expect(tester.takeException(), isNull);
            expect(find.text('180,000 ៛'), findsOneWidget);
            expect(find.byKey(const Key('main-tab-0')), findsOneWidget);
            await tester.ensureVisible(
              find.text(
                locale == 'km'
                    ? 'ការរកឃើញដោយ AI និងប្រាក់ពិន័យដែលបានបញ្ជាក់'
                    : 'AI Detection vs Confirmed Fine',
              ),
            );
            expect(tester.takeException(), isNull);
          },
        );
      }
    }
  }

  testWidgets('Home fine total follows paid demo state', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AppShell()));
    expect(find.text('180,000 ៛'), findsOneWidget);

    demoStore.payFines(['helmet']);
    await tester.pump();
    expect(find.text('150,000 ៛'), findsOneWidget);
    expect(find.text('No fine yet'), findsOneWidget);
  });

  testWidgets('Home shows no fabricated receipt before payment', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: AppShell()));
    expect(find.text('No payments yet'), findsOneWidget);
    expect(find.text('+150,000 ៛'), findsNothing);

    demoStore.payFines(['helmet']);
    await tester.pump();
    expect(find.text('No payments yet'), findsNothing);
    expect(find.text('+30,000 ៛'), findsOneWidget);
  });

  test('phone input drops the local trunk zero', () {
    demoStore.setPhone('012345678');
    expect(demoStore.phone, '12 345 678');
  });

  test('appealing a confirmed fine removes it from payable', () {
    expect(demoStore.payable.map((v) => v.id), contains('speeding'));
    demoStore.submitAppeal('speeding', 'Signal was green');
    expect(demoStore.payable.map((v) => v.id), isNot(contains('speeding')));
  });

  testWidgets('profile language opens the Figma-style sheet', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: ProfileScreen())),
    );

    await tester.ensureVisible(find.text('Language'));
    await tester.tap(find.text('Language'));
    await tester.pumpAndSettle();

    expect(find.text('Choose language'), findsOneWidget);
    expect(find.text('ខ្មែរ'), findsOneWidget);
  });

  testWidgets('violation search matches title, plate, and location', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: ViolationsScreen())),
    );

    await tester.enterText(find.byType(TextField), 'Monivong');
    await tester.pump();

    expect(find.text('No helmet'), findsOneWidget);
    expect(find.text('Speeding (68 km/h in 50 zone)'), findsNothing);
  });

  testWidgets('violation filters show only payable fines', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: ViolationsScreen())),
    );

    await tester.tap(find.text('To pay 2'));
    await tester.pumpAndSettle();

    expect(find.text('Speeding (68 km/h in 50 zone)'), findsOneWidget);
    expect(find.text('Possible red-light violation'), findsNothing);
  });

  testWidgets('paid fines leave the to-pay filter and lose the pay button', (
    tester,
  ) async {
    demoStore.payFines(['helmet']);
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: ViolationsScreen())),
    );

    expect(find.text('To pay 1'), findsOneWidget);
    await tester.tap(find.text('To pay 1'));
    await tester.pumpAndSettle();
    expect(find.text('Speeding (68 km/h in 50 zone)'), findsOneWidget);
    expect(find.text('No helmet'), findsNothing);

    await tester.pumpWidget(
      MaterialApp(home: ViolationDetailScreen(violation: demoViolations[2])),
    );
    expect(find.text('Pay fine'), findsNothing);
    expect(find.text('Paid'), findsOneWidget);
  });

  testWidgets('selected violation opens its own details', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: ViolationsScreen())),
    );

    await tester.tap(find.text('Possible red-light violation'));
    await tester.pumpAndSettle();

    expect(find.text('DEMO-AI-20261014-017'), findsOneWidget);
    expect(find.text('2AB-1234'), findsOneWidget);
    expect(find.textContaining('AI-suspected only'), findsOneWidget);
  });

  testWidgets('selected vehicle opens its own details', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: VehiclesScreen()));

    await tester.tap(find.text('Toyota Prius 2018'));
    await tester.pumpAndSettle();

    expect(find.text('Pearl white'), findsOneWidget);
    expect(find.text('30 Jun 2027'), findsOneWidget);
    expect(find.text('Honda Click 125i'), findsNothing);
  });

  testWidgets('demo payment updates local paid state and receipt view', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: PaymentsScreen())),
    );

    await tester.tap(find.text('Pay 180,000 ៛'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Demo simulation'));
    await tester.tap(find.text('Demo simulation'));
    await tester.pump();
    await tester.tap(find.text('Pay 180,000 ៛'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Confirm & pay'));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Processing payment...'), findsOneWidget);
    expect(find.byKey(const Key('processing-payment-amount')), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pumpAndSettle();

    expect(find.text('Payment successful'), findsOneWidget);
    expect(find.byKey(const Key('success-payment-amount')), findsOneWidget);
    expect(demoStore.paidFineIds, containsAll(['speeding', 'helmet']));
  });

  testWidgets('appeal submission persists and shows success', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: AppealScreen(violation: demoViolations.first)),
    );

    await tester.tap(find.text('Signal was green'));
    await tester.tap(find.text('Submit appeal'));
    await tester.pumpAndSettle();

    expect(find.text('Appeal submitted'), findsOneWidget);
    expect(find.text('Your demo appeal was saved locally.'), findsOneWidget);
    expect(demoStore.appeals['red-light'], 'Signal was green');
  });

  testWidgets('logout clears protected navigation history', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AppShell()));

    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(
      find.text('Log out'),
      find.byType(ListView).last,
      const Offset(0, -300),
    );
    await tester.tap(find.text('Log out'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Profile'), findsNothing);
  });
}
