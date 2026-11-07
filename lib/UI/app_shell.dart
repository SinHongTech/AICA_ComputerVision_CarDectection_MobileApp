import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

import '../l10n/l10n_context.dart';

import '../data/demo_store.dart';
import 'home_screen.dart';
import 'payments_screen.dart';
import 'profile_screen.dart';
import 'violations_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(onSelectTab: (index) => setState(() => _tab = index)),
      ViolationsScreen(),
      PaymentsScreen(),
      ProfileScreen(),
    ];
    final icons = [
      Icons.home_rounded,
      Icons.shield_outlined,
      Icons.account_balance_wallet_outlined,
      Icons.person_outline,
    ];
    final labels = [
      context.l10n.home,
      context.l10n.violations,
      context.l10n.payments,
      context.l10n.profile,
    ];
    return PopScope(
      canPop: _tab == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _tab != 0) setState(() => _tab = 0);
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 390),
              child: IndexedStack(index: _tab, children: pages),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Center(
            heightFactor: 1,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 390),
              child: Container(
                margin: const EdgeInsets.fromLTRB(24, 6, 24, 16),
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                decoration: BoxDecoration(
                  color: aicaSurface(context),
                  border: Border.all(
                    color: isDark(context)
                        ? aicaBorder(context)
                        : const Color(0xFFF1F5F9),
                  ),
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: isDark(context) ? .22 : .12,
                      ),
                      blurRadius: 30,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: List.generate(4, (index) {
                    final selected = _tab == index;
                    return Expanded(
                      child: InkWell(
                        key: Key('main-tab-$index'),
                        onTap: () => setState(() => _tab = index),
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height:
                              Localizations.localeOf(context).languageCode ==
                                  'km'
                              ? 64
                              : 56,
                          decoration: BoxDecoration(
                            color: selected
                                ? (isDark(context)
                                      ? const Color(0xFF203554)
                                      : const Color(0xFFEFF6FF))
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Icon(
                                    icons[index],
                                    size: 20,
                                    color: selected
                                        ? aicaBlue(context)
                                        : aicaMuted(context),
                                  ),
                                  if (index == 1 &&
                                      !selected &&
                                      demoStore.payable.isNotEmpty)
                                    Positioned(
                                      top: -1,
                                      right: -6,
                                      child: Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: aicaTone(
                                            context,
                                            Color(0xFFC32632),
                                          ),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: aicaSurface(context),
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Text(
                                labels[index],
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: aicaFontFamily,
                                  fontFamilyFallback: khmerFontFallback,
                                  color: selected
                                      ? aicaBlue(context)
                                      : aicaMuted(context),
                                  fontSize: 9,
                                  height: 1.1,
                                  fontWeight: selected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
