import 'package:car_detection/UI/app_shell.dart';
import 'package:car_detection/UI/appeal_screen.dart';
import 'package:car_detection/UI/licence_screen.dart';
import 'package:car_detection/UI/notifications_screen.dart';
import 'package:car_detection/UI/onboarding_screen.dart';
import 'package:car_detection/UI/payments_screen.dart';
import 'package:car_detection/UI/profile_screen.dart';
import 'package:car_detection/UI/review_payment_screen.dart';
import 'package:car_detection/UI/settings_screen.dart';
import 'package:car_detection/UI/sign_in_screen.dart';
import 'package:car_detection/UI/vehicle_detail_screen.dart';
import 'package:car_detection/UI/vehicles_screen.dart';
import 'package:car_detection/UI/verify_screen.dart';
import 'package:car_detection/UI/violation_detail_screen.dart';
import 'package:car_detection/UI/violations_screen.dart';
import 'package:car_detection/data/demo_data.dart';
import 'package:car_detection/data/demo_store.dart';
import 'package:car_detection/data/local/local_storage_service.dart';
import 'package:car_detection/data/permissions/notification_permission_service.dart';
import 'package:car_detection/l10n/generated/app_localizations.dart';
import 'package:car_detection/main.dart';
import 'package:car_detection/theme/app_theme.dart';
import 'package:car_detection/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _PermissionGateway implements NotificationPermissionGateway {
  @override
  Future<PermissionStatus> getStatus() async => PermissionStatus.granted;
  @override
  Future<PermissionStatus> request() async => PermissionStatus.granted;
  @override
  Future<bool> openSettings() async => true;
}

Widget _host(Widget screen, String language, bool dark) => MaterialApp(
  locale: Locale(language),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  theme: buildLightTheme(),
  darkTheme: buildDarkTheme(),
  themeMode: dark ? ThemeMode.dark : ThemeMode.light,
  home: Scaffold(body: screen),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(demoStore.reset);

  test('both generated catalogs resolve major screen labels', () async {
    final en = await AppLocalizations.delegate.load(const Locale('en'));
    final km = await AppLocalizations.delegate.load(const Locale('km'));
    expect(en.home, 'Home');
    expect(km.home, 'ទំព័រដើម');
    expect(km.violations, 'បទល្មើសចរាចរណ៍');
    expect(km.payments, 'ការទូទាត់');
    expect(km.profile, 'ប្រវត្តិរូប');
    expect(km.notifications, 'ការជូនដំណឹង');
    expect(km.payAmount('150,000 ៛'), contains('150,000 ៛'));
    expect(km.demoPaymentDisclaimer, contains('មិនមានការផ្ទេរប្រាក់ទេ'));
  });

  test('language and dark mode restore in a new store', () async {
    SharedPreferences.setMockInitialValues({});
    final storage = await LocalStorageService.create();
    final first = DemoStore();
    await first.initialize(storage);
    expect(first.languageCode, 'en');
    expect(first.darkMode, isFalse);
    await first.setLanguage('km');
    await first.setDarkMode(true);
    final restored = DemoStore();
    await restored.initialize(await LocalStorageService.create());
    expect(restored.languageCode, 'km');
    expect(restored.darkMode, isTrue);
    await restored.setLanguage('en');
    expect(restored.languageCode, 'en');
    await storage.clearLocalPreferences();
    expect(storage.isDarkMode(), isFalse);
    first.dispose();
    restored.dispose();
  });

  testWidgets('app responds immediately to language and theme changes', (
    tester,
  ) async {
    await tester.pumpWidget(const SmartTrafficApp());
    await tester.pumpAndSettle();
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).locale,
      const Locale('en'),
    );
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.light,
    );
    await demoStore.setLanguage('km');
    await demoStore.setDarkMode(true);
    await tester.pumpAndSettle();
    expect(find.text('រំលង'), findsOneWidget);
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.dark,
    );
    await demoStore.setLanguage('en');
    await demoStore.setDarkMode(false);
    await tester.pumpAndSettle();
    expect(find.text('Skip'), findsOneWidget);
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.light,
    );
  });

  testWidgets(
    'profile selectors update the active app without losing navigation',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(const SmartTrafficApp());
      await tester.pumpAndSettle();
      final navigator = tester.state<NavigatorState>(
        find.byType(Navigator).first,
      );
      navigator.push(MaterialPageRoute<void>(builder: (_) => const AppShell()));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.person_outline));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Language'));
      await tester.tap(find.text('Language'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('ខ្មែរ'));
      await tester.pumpAndSettle();
      expect(demoStore.languageCode, 'km');
      expect(find.text('ជ្រើសរើសភាសា'), findsOneWidget);
      navigator.pop();
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byType(Switch));
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      expect(demoStore.darkMode, isTrue);
      expect(
        tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
        ThemeMode.dark,
      );
      expect(find.text('ប្រវត្តិរូប'), findsWidgets);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'dark status text has readable contrast on matching backgrounds',
    (tester) async {
      late BuildContext themedContext;
      await tester.pumpWidget(
        _host(
          Builder(
            builder: (context) {
              themedContext = context;
              return const SizedBox();
            },
          ),
          'km',
          true,
        ),
      );
      for (final (foreground, background) in [
        (const Color(0xFFC32632), const Color(0xFFFDEBEC)),
        (const Color(0xFF9D6B00), const Color(0xFFFFF4D9)),
        (const Color(0xFF188653), const Color(0xFFE5F6EB)),
        (const Color(0xFF7542B5), const Color(0xFFF2EAFE)),
      ]) {
        final light = aicaTone(themedContext, foreground).computeLuminance();
        final dark = aicaTone(themedContext, background).computeLuminance();
        expect((light + 0.05) / (dark + 0.05), greaterThanOrEqualTo(4.5));
      }
    },
  );

  testWidgets(
    'Linux notification preferences shows Android availability safely',
    (tester) async {
      final km = await AppLocalizations.delegate.load(const Locale('km'));
      await tester.pumpWidget(
        _host(const NotificationPreferencesScreen(), 'km', true),
      );
      await tester.pumpAndSettle();
      expect(find.text(km.availableOnAndroid), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
    variant: TargetPlatformVariant.only(TargetPlatform.linux),
  );

  for (final language in ['en', 'km']) {
    for (final dark in [false, true]) {
      testWidgets(
        '$language ${dark ? 'dark' : 'light'} screens fit narrow mobile',
        (tester) async {
          await tester.binding.setSurfaceSize(const Size(320, 700));
          addTearDown(() => tester.binding.setSurfaceSize(null));
          await demoStore.setLanguage(language);
          final screens = <Widget>[
            const OnboardingScreen(),
            const SignInScreen(),
            const VerifyScreen(phone: '12345678'),
            const AppShell(),
            const ViolationsScreen(),
            ViolationDetailScreen(violation: demoViolations[1]),
            AppealScreen(violation: demoViolations.first),
            const PaymentsScreen(),
            ReviewPaymentScreen(fines: [demoViolations[1]]),
            const VehiclesScreen(),
            VehicleDetailScreen(vehicle: demoVehicles.first),
            const LicenceScreen(),
            const NotificationsScreen(),
            const ProfileScreen(),
            NotificationPreferencesScreen(
              permissionService: NotificationPermissionService.withGateway(
                _PermissionGateway(),
              ),
            ),
            const PersonalInfoScreen(),
            const PrivacyScreen(),
            const HelpScreen(),
          ];
          for (final screen in screens) {
            await tester.pumpWidget(_host(screen, language, dark));
            await tester.pumpAndSettle();
            expect(
              tester.takeException(),
              isNull,
              reason: '${screen.runtimeType} $language dark=$dark',
            );
            await tester.pumpWidget(const SizedBox());
          }
        },
      );

      testWidgets(
        '$language ${dark ? 'dark' : 'light'} sheets and payment dialog fit',
        (tester) async {
          await tester.binding.setSurfaceSize(const Size(390, 740));
          addTearDown(() => tester.binding.setSurfaceSize(null));
          final localizations = await AppLocalizations.delegate.load(
            Locale(language),
          );
          for (final (screen, action) in <(Widget, String)>[
            (const ProfileScreen(), localizations.language),
            (const VehiclesScreen(), localizations.add),
            (
              ViolationDetailScreen(violation: demoViolations.first),
              localizations.explainThisViolation,
            ),
          ]) {
            await tester.pumpWidget(_host(screen, language, dark));
            await tester.pumpAndSettle();
            await tester.ensureVisible(find.text(action));
            await tester.tap(find.text(action));
            await tester.pumpAndSettle();
            final surface = find
                .descendant(
                  of: find.byType(BottomSheet),
                  matching: find.byType(Material),
                )
                .first;
            expect(tester.getSize(surface).width, lessThanOrEqualTo(390));
            expect(tester.takeException(), isNull);
            await tester.pumpWidget(const SizedBox());
            await tester.pumpAndSettle();
          }
          await tester.pumpWidget(
            _host(
              ReviewPaymentScreen(fines: [demoViolations[1]]),
              language,
              dark,
            ),
          );
          await tester.pumpAndSettle();
          await tester.ensureVisible(find.text(localizations.demoSimulation));
          await tester.tap(find.text(localizations.demoSimulation));
          await tester.pump();
          await tester.tap(find.text(localizations.payAmount('150,000 ៛')));
          await tester.pumpAndSettle();
          expect(find.text(localizations.confirmPayment), findsOneWidget);
          expect(tester.takeException(), isNull);
          await tester.tap(find.text(localizations.confirmAndPay));
          await tester.pump(const Duration(milliseconds: 300));
          await tester.pump(const Duration(milliseconds: 300));
          expect(find.text(localizations.processingPayment), findsOneWidget);
          await tester.pump(const Duration(milliseconds: 1500));
          await tester.pumpAndSettle();
          expect(find.text(localizations.paymentSuccessful), findsOneWidget);
          expect(tester.takeException(), isNull);
        },
      );
    }
  }
}
