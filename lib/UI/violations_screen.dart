import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

import '../l10n/l10n_context.dart';
import '../l10n/demo_labels.dart';

import '../data/demo_data.dart';
import '../model/violation.dart';
import 'violation_detail_screen.dart';
import 'widgets/app_components.dart';

class ViolationsScreen extends StatefulWidget {
  const ViolationsScreen({super.key});
  @override
  State<ViolationsScreen> createState() => _ViolationsScreenState();
}

class _ViolationsScreenState extends State<ViolationsScreen> {
  int _filter = 0;
  String _query = '';

  bool _matchesFilter(Violation violation, int filter) {
    final status = effectiveStatus(violation);
    return switch (filter) {
      1 => status == ViolationStatus.confirmed,
      2 =>
        status == ViolationStatus.suspected ||
            status == ViolationStatus.underReview ||
            status == ViolationStatus.disputed,
      3 => status == ViolationStatus.resolved || status == ViolationStatus.paid,
      _ => true,
    };
  }

  int _countFilter(int filter) =>
      demoViolations.where((v) => _matchesFilter(v, filter)).length;

  @override
  Widget build(BuildContext context) {
    final visible = demoViolations.where((v) {
      final queryMatches =
          '${v.title} ${violationTitle(context, v)} ${v.location} ${v.plate}'
              .toLowerCase()
              .contains(_query.toLowerCase());
      return _matchesFilter(v, _filter) && queryMatches;
    }).toList();
    final filters = [
      context.l10n.allCount(demoViolations.length),
      context.l10n.toPayCount(_countFilter(1)),
      context.l10n.inReviewCount(_countFilter(2)),
      context.l10n.doneCount(_countFilter(3)),
    ];
    return ListView(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 32),
      children: [
        Text(
          context.l10n.violations,
          style: TextStyle(
            fontFamily: aicaFontFamily,
            fontFamilyFallback: khmerFontFallback,
            color: aicaInk(context),
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 10),
        TextField(
          onChanged: (value) => setState(() => _query = value),
          decoration: InputDecoration(
            hintText: context.l10n.searchPlateOrLocation,
            prefixIcon: Icon(Icons.search, color: aicaMuted(context)),
            contentPadding: EdgeInsets.symmetric(vertical: 14),
            filled: true,
            fillColor: aicaSurface(context),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: aicaBorder(context)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: aicaBorder(context)),
            ),
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: aicaBorder(context).withValues(alpha: .6),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: List.generate(
              filters.length,
              (index) => Expanded(
                child: InkWell(
                  onTap: () => setState(() => _filter = index),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _filter == index
                          ? aicaSurface(context)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: _filter == index
                          ? [BoxShadow(color: Color(0x14000000), blurRadius: 3)]
                          : null,
                    ),
                    child: Text(
                      filters[index],
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: aicaFontFamily,
                        fontFamilyFallback: khmerFontFallback,
                        color: _filter == index
                            ? aicaInk(context)
                            : aicaMuted(context),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        Text(
          context.l10n.aiDetectionsAreOnlySuspectedAFine,
          style: TextStyle(
            fontFamily: aicaFontFamily,
            fontFamilyFallback: khmerFontFallback,
            color: aicaMuted(context),
            fontSize: 12,
          ),
        ),
        SizedBox(height: 16),
        AppPanel(
          padding: EdgeInsets.zero,
          child: visible.isEmpty
              ? Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(context.l10n.noMatchingViolations),
                )
              : Column(
                  children: [
                    for (var i = 0; i < visible.length; i++) ...[
                      ViolationTile(
                        violation: visible[i],
                        onTap: () => openPage(
                          context,
                          ViolationDetailScreen(violation: visible[i]),
                        ),
                      ),
                      if (i < visible.length - 1) Divider(height: 1),
                    ],
                  ],
                ),
        ),
      ],
    );
  }
}
