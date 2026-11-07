import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

import '../l10n/l10n_context.dart';
import '../l10n/demo_labels.dart';

import '../data/demo_data.dart';
import '../model/violation.dart';
import 'appeal_screen.dart';
import 'review_payment_screen.dart';
import 'widgets/app_components.dart';

class ViolationDetailScreen extends StatelessWidget {
  const ViolationDetailScreen({super.key, required this.violation});
  final Violation violation;

  @override
  Widget build(BuildContext context) {
    final confirmed = effectiveStatus(violation) == ViolationStatus.confirmed;
    return DetailPage(
      title: context.l10n.violationDetails,
      bottom: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () =>
                  openPage(context, AppealScreen(violation: violation)),
              child: Text(
                confirmed ? context.l10n.appeal : context.l10n.appealOrDispute,
              ),
            ),
          ),
          if (confirmed) ...[
            SizedBox(width: 8),
            Expanded(
              child: FilledButton.icon(
                icon: const Icon(Icons.lock_outline, size: 18),
                onPressed: () {
                  openPage(context, ReviewPaymentScreen(fines: [violation]));
                },
                label: Text(context.l10n.payFine),
              ),
            ),
          ],
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () => showDemoMessage(
              context,
              context.l10n.videoEvidenceIsADemoPlaceholder,
            ),
            child: AspectRatio(
              aspectRatio: 16 / 10,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF10253C), Color(0xFF25446D)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(painter: _EvidencePainter()),
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Color(0xEFFFFFFF),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: aicaInk(context),
                          size: 34,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 14,
                      top: 12,
                      child: Text(
                        '●  CAM-017',
                        style: TextStyle(
                          fontFamily: aicaFontFamily,
                          fontFamilyFallback: khmerFontFallback,
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 14,
                      bottom: 12,
                      child: Text(
                        '${violation.date} ${violation.time}',
                        style: TextStyle(
                          fontFamily: aicaFontFamily,
                          fontFamilyFallback: khmerFontFallback,
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 14,
                      bottom: 12,
                      child: Text(
                        context.l10n.demoPlaceholder,
                        style: TextStyle(
                          fontFamily: aicaFontFamily,
                          fontFamilyFallback: khmerFontFallback,
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: confirmed
                  ? aicaTone(context, Color(0xFFFDEBEC))
                  : aicaTone(context, Color(0xFFEAF1FF)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  confirmed
                      ? context.l10n.officiallyConfirmed
                      : context.l10n.aiSuspectedOnly,
                  style: TextStyle(
                    fontFamily: aicaFontFamily,
                    fontFamilyFallback: khmerFontFallback,
                    color: confirmed
                        ? aicaTone(context, Color(0xFFC32632))
                        : aicaBlue(context),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  confirmed
                      ? context.l10n.reviewTheDetailsYouMayPayOr
                      : context.l10n.noFineExistsAnOfficerMustReview,
                  style: TextStyle(
                    fontFamily: aicaFontFamily,
                    fontFamilyFallback: khmerFontFallback,
                    color: aicaMuted(context),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  violationTitle(context, violation),
                  style: TextStyle(
                    fontFamily: aicaFontFamily,
                    fontFamilyFallback: khmerFontFallback,
                    color: aicaInk(context),
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              StatusBadge(effectiveStatus(violation)),
            ],
          ),
          SizedBox(height: 12),
          FilledButton.tonalIcon(
            onPressed: () => showMobileBottomSheet<void>(
              context: context,
              showDragHandle: true,
              builder: (sheetContext) => SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        context.l10n.whatDoesThisMean,
                        style: TextStyle(
                          fontFamily: aicaFontFamily,
                          fontFamilyFallback: khmerFontFallback,
                          color: aicaInk(context),
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 14),
                      Text(context.l10n.ourCameraSystemNoticedThatYourVehicle),
                      SizedBox(height: 14),
                      Text(context.l10n.explanationChecks),
                      SizedBox(height: 20),
                      FilledButton(
                        onPressed: () => Navigator.pop(sheetContext),
                        child: Text(context.l10n.gotIt),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            icon: Icon(Icons.help_outline),
            label: Text(context.l10n.explainThisViolation),
          ),
          SizedBox(height: 24),
          SectionTitle(context.l10n.incident),
          AppPanel(
            child: Column(
              children: [
                InfoRow(context.l10n.location, violation.location),
                Divider(height: 1),
                InfoRow(
                  context.l10n.dateTime,
                  '${violation.date} · ${violation.time}',
                ),
                Divider(height: 1),
                InfoRow(context.l10n.reference, violation.reference),
              ],
            ),
          ),
          SizedBox(height: 24),
          SectionTitle(context.l10n.vehicle),
          AppPanel(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: aicaSurface(context),
                        border: Border.all(color: aicaInk(context), width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'CAMBODIA · ព្រះរាជាណាចក្រកម្ពុជា',
                            style: TextStyle(
                              fontFamily: aicaFontFamily,
                              fontFamilyFallback: khmerFontFallback,
                              color: aicaBlue(context),
                              fontSize: 6,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            violation.plate,
                            style: TextStyle(
                              fontFamily: aicaFontFamily,
                              fontFamilyFallback: khmerFontFallback,
                              color: aicaInk(context),
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Flexible(
                  child: Text(
                    violation.plate == '2AB-1234'
                        ? 'Toyota Prius'
                        : 'Honda Click 125i',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: aicaFontFamily,
                      fontFamilyFallback: khmerFontFallback,
                      color: aicaMuted(context),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          SectionTitle(context.l10n.officialFine),
          AppPanel(
            child: confirmed
                ? Column(
                    children: [
                      InfoRow(context.l10n.baseFine, riel(violation.amount)),
                      Divider(height: 1),
                      InfoRow(context.l10n.serviceFee, '0 ៛'),
                      Divider(height: 1),
                      InfoRow(context.l10n.payBy, '31 Oct 2026'),
                      Divider(height: 1),
                      InfoRow(context.l10n.total, riel(violation.amount)),
                    ],
                  )
                : Row(
                    children: [
                      Icon(
                        Icons.gpp_maybe_outlined,
                        color: aicaTone(context, Color(0xFF9D6B00)),
                        size: 26,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          context.l10n.noOfficialFineHasBeenIssuedFor,
                          style: TextStyle(
                            fontFamily: aicaFontFamily,
                            fontFamilyFallback: khmerFontFallback,
                            color: aicaMuted(context),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _EvidencePainter extends CustomPainter {
  const _EvidencePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final road = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width * .38, size.height * .48)
      ..lineTo(size.width * .62, size.height * .48)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(road, Paint()..color = Color(0xFF0D1623));
    canvas.drawLine(
      Offset(size.width / 2, size.height * .5),
      Offset(size.width / 2, size.height),
      Paint()
        ..color = Colors.white38
        ..strokeWidth = 2,
    );
    final vehicle = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * .55, size.height * .60, 52, 30),
      Radius.circular(6),
    );
    canvas.drawRRect(vehicle, Paint()..color = Color(0xFFD9E2EC));
    canvas.drawRect(
      Rect.fromLTWH(size.width * .52, size.height * .54, 70, 52),
      Paint()
        ..color = Colors.transparent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = Color(0xFFF59E0B),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
