import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

import '../l10n/l10n_context.dart';
import '../l10n/demo_labels.dart';

import '../data/demo_data.dart';
import '../data/demo_store.dart';
import 'violation_detail_screen.dart';
import 'widgets/app_components.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: demoStore,
    builder: (context, _) => DetailPage(
      title: context.l10n.notifications,
      actions: [
        TextButton(
          onPressed: demoStore.markAllRead,
          child: Text(
            context.l10n.markAllRead,
            style: TextStyle(
              fontFamily: aicaFontFamily,
              fontFamilyFallback: khmerFontFallback,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: 4),
      ],
      child: Column(
        children: [
          for (var i = 0; i < demoNotifications.length; i++) ...[
            InkWell(
              onTap: () {
                demoStore.markRead(i);
                final violation = violationById(
                  demoNotifications[i].violationId ?? '',
                );
                if (violation != null) {
                  openPage(
                    context,
                    ViolationDetailScreen(violation: violation),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: demoStore.readNotificationIds.contains(i)
                      ? aicaSurface(context)
                      : aicaTone(context, Color(0xFFEAF1FF)),
                  border: Border.all(
                    color: demoStore.readNotificationIds.contains(i)
                        ? aicaBorder(context)
                        : aicaBlue(context).withValues(alpha: .3),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _notificationColor(
                          i,
                          context,
                        ).withValues(alpha: .12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        _notificationIcon(i),
                        color: _notificationColor(i, context),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  notificationTitle(context, i),
                                  style: TextStyle(
                                    fontFamily: aicaFontFamily,
                                    fontFamilyFallback: khmerFontFallback,
                                    color: aicaInk(context),
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              if (!demoStore.readNotificationIds.contains(i))
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor: aicaBlue(context),
                                ),
                            ],
                          ),
                          SizedBox(height: 2),
                          Text(
                            notificationMessage(context, i),
                            style: TextStyle(
                              fontFamily: aicaFontFamily,
                              fontFamilyFallback: khmerFontFallback,
                              color: aicaMuted(context),
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            notificationWhen(context, i),
                            style: TextStyle(
                              fontFamily: aicaFontFamily,
                              fontFamilyFallback: khmerFontFallback,
                              color: aicaMuted(context),
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ],
      ),
    ),
  );

  static IconData _notificationIcon(int index) => switch (index) {
    0 => Icons.videocam,
    1 => Icons.gavel,
    2 => Icons.schedule,
    3 => Icons.forum,
    4 => Icons.check_circle,
    _ => Icons.badge,
  };

  static Color _notificationColor(int index, BuildContext context) =>
      switch (index) {
        0 || 2 => aicaTone(context, Color(0xFF9D6B00)),
        1 => aicaTone(context, Color(0xFFC32632)),
        3 => aicaTone(context, Color(0xFF7542B5)),
        4 => aicaTone(context, Color(0xFF188653)),
        _ => aicaBlue(context),
      };
}
