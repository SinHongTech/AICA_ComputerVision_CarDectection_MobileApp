import 'package:flutter/material.dart';

import '../data/demo_data.dart';
import '../data/demo_store.dart';
import '../l10n/demo_labels.dart';
import '../l10n/l10n_context.dart';
import '../model/violation.dart';
import '../theme/app_colors.dart';
import 'licence_screen.dart';
import 'notifications_screen.dart';
import 'vehicles_screen.dart';
import 'violation_detail_screen.dart';
import 'widgets/app_components.dart';

String _greeting(BuildContext context) {
  final hour = DateTime.now().hour;
  if (hour < 12) return context.l10n.goodMorning;
  if (hour < 18) return context.l10n.goodAfternoon;
  return context.l10n.goodEvening;
}

TextStyle _type(
  double size,
  FontWeight weight,
  Color color, {
  double? height,
}) => TextStyle(
  fontFamily: aicaFontFamily,
  fontFamilyFallback: khmerFontFallback,
  fontSize: size,
  fontWeight: weight,
  color: color,
  height: height,
);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onSelectTab});

  final ValueChanged<int> onSelectTab;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: demoStore,
    builder: (context, _) {
      final total = demoStore.payable.fold<int>(
        0,
        (sum, violation) => sum + violation.amount,
      );
      return ColoredBox(
        color: isDark(context) ? const Color(0xFF101A2C) : Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _Hero(total: total, onSelectTab: onSelectTab),
            _Activity(onSelectTab: onSelectTab),
          ],
        ),
      );
    },
  );
}

class _Hero extends StatelessWidget {
  const _Hero({required this.total, required this.onSelectTab});

  final int total;
  final ValueChanged<int> onSelectTab;

  @override
  Widget build(BuildContext context) {
    final dark = isDark(context);
    final vehicle = demoVehicles.first;
    final vehicleName = vehicle.name.replaceFirst(RegExp(r' \d{4}$'), '');
    final initials = userInitials(demoStore.name);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 26),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: dark
              ? const [Color(0xFF062C75), Color(0xFF1652BE), Color(0xFF24375E)]
              : const [Color(0xFF0848C9), Color(0xFF1E6BFA), Color(0xFFE3EFFF)],
          stops: const [0, .57, 1],
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 21,
                backgroundColor: Colors.white.withValues(alpha: .25),
                child: Text(
                  initials,
                  style: _type(13, FontWeight.w700, Colors.white),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_greeting(context)},',
                      style: _type(
                        11,
                        FontWeight.w500,
                        const Color(0xFFE1EBFF),
                      ),
                    ),
                    Text(
                      demoStore.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: _type(16, FontWeight.w700, Colors.white),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: context.l10n.notifications,
                onPressed: () => openPage(context, const NotificationsScreen()),
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0x33093DB0),
                  side: const BorderSide(color: Color(0x33FFFFFF)),
                  fixedSize: const Size(40, 40),
                ),
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 21,
                    ),
                    if (demoStore.hasUnreadNotifications)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEF4444),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 27),
          _HeroPill(
            icon: Icons.circle,
            iconSize: 8,
            iconColor: const Color(0xFF4ADE80),
            label: '${vehicle.plate} · $vehicleName',
          ),
          const SizedBox(height: 10),
          Text(
            context.l10n.homeOutstandingConfirmedFines,
            textAlign: TextAlign.center,
            style: _type(12, FontWeight.w500, const Color(0xFFE1EBFF)),
          ),
          const SizedBox(height: 3),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              riel(total),
              style: _type(36, FontWeight.w800, Colors.white),
            ),
          ),
          const SizedBox(height: 7),
          _HeroPill(
            icon: Icons.info_outline,
            iconSize: 15,
            iconColor: const Color(0xFFB7F7D3),
            label: context.l10n.homeLicencePointsUnavailable,
          ),
          const SizedBox(height: 34),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _QuickAction(
                  icon: Icons.shield_outlined,
                  label: context.l10n.violations,
                  dark: dark,
                  onTap: () => onSelectTab(1),
                ),
              ),
              Expanded(
                child: _QuickAction(
                  icon: Icons.payments_outlined,
                  label: context.l10n.payFines,
                  dark: dark,
                  onTap: () => onSelectTab(2),
                ),
              ),
              Expanded(
                child: _QuickAction(
                  icon: Icons.directions_car_outlined,
                  label: context.l10n.vehicles,
                  dark: dark,
                  onTap: () => openPage(context, const VehiclesScreen()),
                ),
              ),
              Expanded(
                child: _QuickAction(
                  icon: Icons.badge_outlined,
                  label: context.l10n.licence,
                  dark: dark,
                  onTap: () => openPage(context, const LicenceScreen()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroPill extends StatelessWidget {
  const _HeroPill({
    required this.icon,
    required this.iconSize,
    required this.iconColor,
    required this.label,
  });

  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final String label;

  @override
  Widget build(BuildContext context) => Container(
    constraints: const BoxConstraints(maxWidth: 320),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: .19),
      border: Border.all(color: Colors.white.withValues(alpha: .14)),
      borderRadius: BorderRadius.circular(100),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: iconSize, color: iconColor),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            label,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: _type(11, FontWeight.w600, Colors.white),
          ),
        ),
      ],
    ),
  );
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.dark,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool dark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: dark ? const Color(0xFF213B6A) : Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .06),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 23,
              color: dark ? Colors.white : aicaBlue(context),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: _type(
              11,
              FontWeight.w600,
              dark ? Colors.white : const Color(0xFF1E293B),
              height: 1.2,
            ),
          ),
        ],
      ),
    ),
  );
}

class _Activity extends StatelessWidget {
  const _Activity({required this.onSelectTab});

  final ValueChanged<int> onSelectTab;

  @override
  Widget build(BuildContext context) {
    final dark = isDark(context);
    final speeding = violationById('speeding');
    final possible = violationById('red-light');
    final speedingPaid =
        speeding != null && demoStore.paidFineIds.contains(speeding.id);
    final paidTotal = demoViolations
        .where((v) => demoStore.paidFineIds.contains(v.id))
        .fold<int>(0, (sum, v) => sum + v.amount);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF172536) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: dark ? const Color(0xFF3B4D63) : const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: dark ? const Color(0xFF403820) : const Color(0xFFFFFBEB),
              border: Border.all(
                color: dark ? const Color(0xFF80672D) : const Color(0xFFFDE8A9),
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 20,
                  color: Color(0xFFB45309),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.homeAiDetectionTitle,
                        style: _type(
                          12,
                          FontWeight.w700,
                          dark
                              ? const Color(0xFFFFD477)
                              : const Color(0xFF78350F),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        context.l10n.homeAiDetectionBody,
                        style: _type(
                          11,
                          FontWeight.w400,
                          dark
                              ? const Color(0xFFFFE5B3)
                              : const Color(0xFF92400E),
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text(
                  context.l10n.homeRecentActivity,
                  maxLines: 2,
                  style: _type(
                    16,
                    FontWeight.w700,
                    dark ? Colors.white : aicaInk(context),
                    height: 1.2,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => onSelectTab(1),
                child: Text(
                  context.l10n.homeViewAll,
                  style: _type(12, FontWeight.w600, aicaBlue(context)),
                ),
              ),
            ],
          ),
          if (speeding != null)
            _ActivityRow(
              icon: Icons.speed,
              title: violationTitle(context, speeding),
              subtitle: _violationSubtitle(speeding),
              amount: speedingPaid
                  ? riel(speeding.amount)
                  : '-${riel(speeding.amount)}',
              badge: speedingPaid
                  ? context.l10n.paid
                  : context.l10n.homeConfirmed,
              tone: speedingPaid
                  ? (dark ? const Color(0xFF78D8A9) : const Color(0xFF047857))
                  : (dark ? const Color(0xFFFFA1A8) : const Color(0xFFDC2626)),
              badgeBackground: speedingPaid
                  ? (dark ? const Color(0xFF203C33) : const Color(0xFFECFDF5))
                  : (dark ? const Color(0xFF462A34) : const Color(0xFFFEF2F2)),
              onTap: () =>
                  openPage(context, ViolationDetailScreen(violation: speeding)),
            ),
          if (possible != null)
            _ActivityRow(
              icon: Icons.traffic,
              title: violationTitle(context, possible),
              subtitle: _violationSubtitle(possible),
              amount: context.l10n.homeNoFineYet,
              badge: context.l10n.homeUnderAiReview,
              tone: dark ? const Color(0xFFFFD477) : const Color(0xFFB45309),
              badgeBackground: dark
                  ? const Color(0xFF403820)
                  : const Color(0xFFFFFBEB),
              onTap: () =>
                  openPage(context, ViolationDetailScreen(violation: possible)),
            ),
          _ActivityRow(
            icon: Icons.verified_user_outlined,
            title: context.l10n.homeVehicleOnFile,
            subtitle:
                '${demoVehicles.first.plate} · ${demoVehicles.first.name}',
            badge: context.l10n.homeDemoRecord,
            tone: dark ? const Color(0xFF78D8A9) : const Color(0xFF047857),
            badgeBackground: dark
                ? const Color(0xFF203C33)
                : const Color(0xFFECFDF5),
            onTap: () => openPage(context, const VehiclesScreen()),
          ),
          _ActivityRow(
            icon: Icons.receipt_long_outlined,
            title: context.l10n.homeDemoReceipt,
            subtitle: context.l10n.homePrototypeSimulation,
            amount: paidTotal > 0
                ? '+${riel(paidTotal)}'
                : context.l10n.homeNoPaymentsYet,
            badge: context.l10n.homeDemoPaid,
            tone: dark ? const Color(0xFF78D8A9) : const Color(0xFF047857),
            badgeBackground: dark
                ? const Color(0xFF203C33)
                : const Color(0xFFECFDF5),
            onTap: () => onSelectTab(2),
          ),
        ],
      ),
    );
  }
}

String _violationSubtitle(Violation violation) =>
    '${violation.date} · ${violation.time} · ${violation.location}';

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.tone,
    required this.badgeBackground,
    required this.onTap,
    this.amount,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String? amount;
  final String badge;
  final Color tone;
  final Color badgeBackground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dark = isDark(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: dark ? const Color(0xFF304158) : const Color(0xFFF1F5F9),
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: dark
                      ? const Color(0xFF24364C)
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  size: 22,
                  color: dark
                      ? const Color(0xFFD6E4F5)
                      : const Color(0xFF475569),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: _type(
                        12,
                        FontWeight.w600,
                        dark ? Colors.white : aicaInk(context),
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: _type(
                        10,
                        FontWeight.w400,
                        aicaMuted(context),
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 7),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (amount != null) ...[
                      Text(
                        amount!,
                        maxLines: 2,
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        style: _type(
                          11,
                          FontWeight.w700,
                          dark ? Colors.white : aicaInk(context),
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: badgeBackground,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        badge,
                        maxLines: 2,
                        textAlign: TextAlign.right,
                        style: _type(9, FontWeight.w600, tone, height: 1.15),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
