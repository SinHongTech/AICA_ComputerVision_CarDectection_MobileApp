import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'l10n/generated/app_localizations.dart';
import 'theme/app_theme.dart';

import 'UI/splash_screen.dart';
import 'UI/widgets/app_components.dart';
import 'data/auth/user_repository.dart';
import 'data/demo_store.dart';
import 'data/local/local_storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SmartTrafficApp());
}

class SmartTrafficApp extends StatefulWidget {
  const SmartTrafficApp({
    super.key,
    this.storageFactory,
    this.debugResetOnboarding,
  });

  final Future<LocalStorageService> Function()? storageFactory;

  /// Test override; production uses the compile-time dart-define below.
  final bool? debugResetOnboarding;

  @override
  State<SmartTrafficApp> createState() => _SmartTrafficAppState();
}

class _SmartTrafficAppState extends State<SmartTrafficApp> {
  late final Future<bool> _startup = _loadPreferences();

  Future<bool> _loadPreferences() async {
    final localStorage =
        await (widget.storageFactory?.call() ?? LocalStorageService.create());
    if (kDebugMode &&
        (widget.debugResetOnboarding ??
            const bool.fromEnvironment('AICA_RESET_ONBOARDING'))) {
      await localStorage.resetOnboardingForDebug();
    }
    await demoStore.initialize(localStorage, userRepository: appUserRepository);
    return demoStore.hasCompletedOnboarding;
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: demoStore,
    builder: (context, _) => MaterialApp(
      title: 'Cambodia Smart Traffic',
      navigatorObservers: [ClearMessagesOnNavigation()],
      builder: (context, child) => Center(
        child: SizedBox(width: mobileContentWidth, child: child),
      ),
      debugShowCheckedModeBanner: false,
      locale: Locale(demoStore.languageCode),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: demoStore.darkMode ? ThemeMode.dark : ThemeMode.light,
      home: SplashScreen(startup: _startup),
    ),
  );
}
