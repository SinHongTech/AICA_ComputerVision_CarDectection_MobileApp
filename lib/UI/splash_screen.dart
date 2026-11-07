import 'package:flutter/material.dart';

import '../data/demo_store.dart';
import '../l10n/l10n_context.dart';
import '../theme/app_colors.dart';
import 'app_shell.dart';
import 'onboarding_screen.dart';
import 'sign_in_screen.dart';
import 'widgets/app_components.dart';

/// First rendered screen; saved preferences load while this is visible.
class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    required this.startup,
    this.minimumDuration = const Duration(milliseconds: 900),
  });

  final Future<bool> startup;
  final Duration minimumDuration;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _finishStartup();
  }

  Future<void> _finishStartup() async {
    final minimumDisplay = Future<void>.delayed(widget.minimumDuration);
    final completedOnboarding = await widget.startup;
    await minimumDisplay;
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => demoStore.isSignedIn
            ? const AppShell()
            : completedOnboarding
            ? const SignInScreen()
            : const OnboardingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: mobileContentWidth),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 88,
                  height: 88,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF102A43),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.traffic_rounded,
                    color: Color(0xFF60A5FA),
                    size: 52,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'AICA',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: aicaFontFamily,
                    fontFamilyFallback: khmerFontFallback,
                    color: aicaInk(context),
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  context.l10n.cambodiaSmartTraffic,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: aicaFontFamily,
                    fontFamilyFallback: khmerFontFallback,
                    color: aicaMuted(context),
                    fontSize: 16,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: aicaBlue(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
