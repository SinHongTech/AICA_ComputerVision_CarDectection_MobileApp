import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

import '../l10n/l10n_context.dart';

import '../data/demo_store.dart';
import 'licence_screen.dart';
import 'settings_screen.dart';
import 'sign_in_screen.dart';
import 'vehicles_screen.dart';
import 'widgets/app_components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showLanguageSheet(BuildContext context) {
    showMobileBottomSheet<void>(
      context: context,
      showDragHandle: false,
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: EdgeInsets.fromLTRB(20, 12, 20, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 6,
                  decoration: BoxDecoration(
                    color: aicaBorder(context),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                context.l10n.chooseLanguage,
                style: TextStyle(
                  fontFamily: aicaFontFamily,
                  fontFamilyFallback: khmerFontFallback,
                  color: aicaInk(context),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16),
              for (final (iconText, language, languageCode) in [
                ('EN', 'English', 'en'),
                ('ខ្ម', 'ខ្មែរ', 'km'),
              ]) ...[
                InkWell(
                  onTap: () {
                    demoStore.setLanguage(languageCode);
                    setSheetState(() {});
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: demoStore.languageCode == languageCode
                          ? aicaTone(context, Color(0xFFEAF1FF))
                          : aicaSurface(context),
                      border: Border.all(
                        color: demoStore.languageCode == languageCode
                            ? aicaBlue(context)
                            : aicaBorder(context),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ink,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            iconText,
                            style: TextStyle(
                              fontFamily: aicaFontFamily,
                              fontFamilyFallback: khmerFontFallback,
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            language,
                            style: TextStyle(
                              fontFamily: aicaFontFamily,
                              fontFamilyFallback: khmerFontFallback,
                              color: aicaInk(context),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (demoStore.languageCode == languageCode)
                          Icon(Icons.check_circle, color: aicaBlue(context)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: demoStore,
    builder: (context, _) => ListView(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 32),
      children: [
        Text(
          context.l10n.profile,
          style: TextStyle(
            fontFamily: aicaFontFamily,
            fontFamilyFallback: khmerFontFallback,
            color: aicaInk(context),
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 12),
        AppPanel(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: ink,
                child: Text(
                  userInitials(demoStore.name),
                  style: TextStyle(
                    fontFamily: aicaFontFamily,
                    fontFamilyFallback: khmerFontFallback,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 19,
                  ),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      demoStore.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: aicaFontFamily,
                        fontFamilyFallback: khmerFontFallback,
                        color: aicaInk(context),
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '+855 ${demoStore.phone}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: aicaFontFamily,
                        fontFamilyFallback: khmerFontFallback,
                        color: aicaMuted(context),
                        fontSize: 13,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: aicaTone(context, Color(0xFFE5F6EB)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        context.l10n.phoneVerified,
                        style: TextStyle(
                          fontFamily: aicaFontFamily,
                          fontFamilyFallback: khmerFontFallback,
                          color: aicaTone(context, Color(0xFF188653)),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
        Text(
          context.l10n.myAccount,
          style: TextStyle(
            fontFamily: aicaFontFamily,
            fontFamilyFallback: khmerFontFallback,
            color: aicaMuted(context),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10),
        AppPanel(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _MenuRow(
                Icons.person_outline,
                context.l10n.personalInformation,
                () => openPage(context, PersonalInfoScreen()),
              ),
              Divider(height: 1),
              _MenuRow(
                Icons.directions_car_outlined,
                context.l10n.myVehicles,
                () => openPage(context, VehiclesScreen()),
                subtitle: context.l10n.label2Registered,
              ),
              Divider(height: 1),
              _MenuRow(
                Icons.badge_outlined,
                context.l10n.drivingLicenceLabelAlt,
                () => openPage(context, LicenceScreen()),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
        Text(
          context.l10n.settingsLabel,
          style: TextStyle(
            fontFamily: aicaFontFamily,
            fontFamilyFallback: khmerFontFallback,
            color: aicaMuted(context),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10),
        AppPanel(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _MenuRow(
                Icons.translate,
                context.l10n.language,
                () => _showLanguageSheet(context),
                subtitle: demoStore.languageName,
              ),
              Divider(height: 1),
              AppMenuRow(
                icon: Icons.dark_mode_outlined,
                label: context.l10n.darkMode,
                trailing: Switch(
                  value: demoStore.darkMode,
                  onChanged: demoStore.setDarkMode,
                ),
              ),
              Divider(height: 1),
              _MenuRow(
                Icons.notifications_none,
                context.l10n.notificationPreferences,
                () => openPage(context, NotificationPreferencesScreen()),
              ),
              Divider(height: 1),
              _MenuRow(
                Icons.lock_outline,
                context.l10n.privacySecurity,
                () => openPage(context, PrivacyScreen()),
              ),
              Divider(height: 1),
              _MenuRow(
                Icons.help_outline,
                context.l10n.helpSupport,
                () => openPage(context, HelpScreen()),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
        FilledButton.icon(
          onPressed: () async {
            await demoStore.signOut();
            if (!context.mounted) return;
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute<void>(builder: (_) => SignInScreen()),
              (_) => false,
            );
          },
          icon: Icon(Icons.logout),
          label: Text(context.l10n.logOut),
          style: FilledButton.styleFrom(
            backgroundColor: aicaTone(context, Color(0xFFFDEBEC)),
            foregroundColor: aicaTone(context, Color(0xFFC32632)),
          ),
        ),
        SizedBox(height: 16),
        Text(
          context.l10n.cambodiaSmartTrafficV100Demo,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: aicaFontFamily,
            fontFamilyFallback: khmerFontFallback,
            color: aicaMuted(context),
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

class _MenuRow extends StatelessWidget {
  const _MenuRow(this.icon, this.label, this.onTap, {this.subtitle});
  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) =>
      AppMenuRow(icon: icon, label: label, subtitle: subtitle, onTap: onTap);
}
