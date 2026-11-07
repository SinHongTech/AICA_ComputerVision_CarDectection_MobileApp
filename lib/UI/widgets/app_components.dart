import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

import '../../l10n/l10n_context.dart';
import '../../l10n/demo_labels.dart';

import '../../data/demo_data.dart';
import '../../model/violation.dart';

const ink = Color(0xFF102A43);

const mobileContentWidth = 390.0;

/// Up to two initials from a display name, used by the avatar badges.
String userInitials(String name) => name
    .trim()
    .split(RegExp(r'\s+'))
    .where((part) => part.isNotEmpty)
    .take(2)
    .map((part) => part[0].toUpperCase())
    .join();

Future<T?> showMobileBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool showDragHandle = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    constraints: BoxConstraints(maxWidth: mobileContentWidth),
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: aicaSurface(context),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    showDragHandle: showDragHandle,
    builder: (context) => SafeArea(
      top: false,
      child: SingleChildScrollView(child: builder(context)),
    ),
  );
}

/// Prevents a message from following the user onto another route.
class ClearMessagesOnNavigation extends NavigatorObserver {
  void _clear(Route<dynamic>? route) {
    final context = navigator?.context;
    if (context != null) {
      ScaffoldMessenger.maybeOf(context)?.clearSnackBars();
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _clear(route);

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _clear(route);

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) =>
      _clear(newRoute);
}

void openPage(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page));
}

class AppPanel extends StatelessWidget {
  const AppPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });
  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => Container(
    padding: padding,
    decoration: BoxDecoration(
      color: aicaSurface(context),
      border: Border.all(color: aicaBorder(context)),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Color(0x0A102A43),
          blurRadius: 2,
          offset: Offset(0, 1),
        ),
        BoxShadow(
          color: Color(0x2E102A43),
          blurRadius: 24,
          offset: Offset(0, 8),
          spreadRadius: -14,
        ),
      ],
    ),
    child: Material(type: MaterialType.transparency, child: child),
  );
}

class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
    required this.title,
    required this.child,
    this.bottom,
    this.actions,
  });
  final String title;
  final Widget child;
  final Widget? bottom;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      toolbarHeight: 60,
      leadingWidth: 56,
      titleSpacing: 8,
      leading: Padding(
        padding: EdgeInsets.only(left: 12),
        child: IconButton(
          tooltip: context.l10n.back,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: aicaInk(context)),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: aicaFontFamily,
          fontFamilyFallback: khmerFontFallback,
          color: aicaInk(context),
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: actions,
    ),
    body: Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 390),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: child,
              ),
            ),
            if (bottom != null)
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(16, 12, 16, 20),
                decoration: BoxDecoration(
                  color: aicaSurface(context),
                  border: Border(top: BorderSide(color: aicaBorder(context))),
                ),
                child: bottom!,
              ),
          ],
        ),
      ),
    ),
  );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: 12),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: aicaFontFamily,
        fontFamilyFallback: khmerFontFallback,
        color: aicaInk(context),
        fontSize: 16,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

class AppMenuRow extends StatelessWidget {
  const AppMenuRow({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.subtitle,
    this.trailing,
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: danger
                  ? aicaTone(context, Color(0xFFFDEBEC))
                  : aicaTone(context, Color(0xFFEAF1FF)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: danger
                  ? aicaTone(context, Color(0xFFC32632))
                  : aicaBlue(context),
              size: 22,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: aicaFontFamily,
                    fontFamilyFallback: khmerFontFallback,
                    color: aicaInk(context),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontFamily: aicaFontFamily,
                      fontFamilyFallback: khmerFontFallback,
                      color: aicaMuted(context),
                      fontSize: 12.5,
                    ),
                  ),
              ],
            ),
          ),
          trailing ??
              (onTap == null
                  ? SizedBox.shrink()
                  : Icon(Icons.chevron_right, color: aicaMuted(context))),
        ],
      ),
    ),
  );
}

class InfoRow extends StatelessWidget {
  const InfoRow(this.label, this.value, {super.key});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: aicaFontFamily,
              fontFamilyFallback: khmerFontFallback,
              color: aicaMuted(context),
              fontSize: 14,
            ),
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: aicaFontFamily,
              fontFamilyFallback: khmerFontFallback,
              color: aicaInk(context),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

class StatusBadge extends StatelessWidget {
  const StatusBadge(this.status, {super.key});
  final ViolationStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, icon, color, bg) = switch (status) {
      ViolationStatus.suspected => (
        context.l10n.aiSuspected,
        Icons.auto_awesome,
        aicaBlue(context),
        aicaTone(context, Color(0xFFEAF1FF)),
      ),
      ViolationStatus.confirmed => (
        context.l10n.confirmedFine,
        Icons.verified,
        aicaTone(context, Color(0xFFC32632)),
        aicaTone(context, Color(0xFFFDEBEC)),
      ),
      ViolationStatus.underReview => (
        context.l10n.underReview,
        Icons.hourglass_top,
        aicaTone(context, Color(0xFF9D6B00)),
        aicaTone(context, Color(0xFFFFF4D9)),
      ),
      ViolationStatus.disputed => (
        context.l10n.disputed,
        Icons.forum,
        aicaTone(context, Color(0xFF7542B5)),
        aicaTone(context, Color(0xFFF2EAFE)),
      ),
      ViolationStatus.resolved => (
        context.l10n.resolved,
        Icons.check_circle,
        aicaTone(context, Color(0xFF188653)),
        aicaTone(context, Color(0xFFE5F6EB)),
      ),
      ViolationStatus.paid => (
        context.l10n.paid,
        Icons.receipt_long,
        aicaTone(context, Color(0xFF188653)),
        aicaTone(context, Color(0xFFE5F6EB)),
      ),
    };
    return Container(
      constraints: const BoxConstraints(maxWidth: 130),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 13),
          SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: aicaFontFamily,
                fontFamilyFallback: khmerFontFallback,
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ViolationTile extends StatelessWidget {
  const ViolationTile({
    super.key,
    required this.violation,
    required this.onTap,
  });
  final Violation violation;
  final VoidCallback onTap;

  (IconData, Color, Color) _visual(BuildContext context) =>
      switch (violation.id) {
        'red-light' => (
          Icons.traffic,
          aicaBlue(context),
          aicaTone(context, Color(0xFFEAF1FF)),
        ),
        'speeding' => (
          Icons.speed,
          aicaTone(context, Color(0xFFC32632)),
          aicaTone(context, Color(0xFFFDEBEC)),
        ),
        'helmet' => (
          Icons.sports_motorsports,
          aicaTone(context, Color(0xFFC32632)),
          aicaTone(context, Color(0xFFFDEBEC)),
        ),
        'parking' => (
          Icons.local_parking,
          aicaTone(context, Color(0xFF9D6B00)),
          aicaTone(context, Color(0xFFFFF4D9)),
        ),
        'wrong-way' => (
          Icons.u_turn_left,
          aicaTone(context, Color(0xFF7542B5)),
          aicaTone(context, Color(0xFFF2EAFE)),
        ),
        _ => (
          Icons.remove_road,
          aicaTone(context, Color(0xFF188653)),
          aicaTone(context, Color(0xFFE5F6EB)),
        ),
      };

  @override
  Widget build(BuildContext context) {
    final (icon, iconColor, iconBackground) = _visual(context);
    return LayoutBuilder(
      builder: (context, constraints) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth < 350 ? 12 : 16,
            vertical: 14,
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      violationTitle(context, violation),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: aicaFontFamily,
                        fontFamilyFallback: khmerFontFallback,
                        color: aicaInk(context),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      '${violation.date} · ${violation.location}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: aicaFontFamily,
                        fontFamilyFallback: khmerFontFallback,
                        color: aicaMuted(context),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    violation.amount > 0
                        ? riel(violation.amount)
                        : context.l10n.noFine,
                    style: TextStyle(
                      fontFamily: aicaFontFamily,
                      fontFamilyFallback: khmerFontFallback,
                      color: violation.amount > 0
                          ? aicaInk(context)
                          : aicaMuted(context),
                      fontSize: violation.amount > 0 ? 14 : 11.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4),
                  StatusBadge(effectiveStatus(violation)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showDemoMessage(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(SnackBar(content: Text(text)));
}
