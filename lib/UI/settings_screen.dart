import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

import '../l10n/l10n_context.dart';
import '../l10n/demo_labels.dart';

import '../data/demo_store.dart';
import '../data/permissions/notification_permission_service.dart';
import 'widgets/app_components.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});
  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  late final _name = TextEditingController(text: demoStore.name);
  late final _email = TextEditingController(text: demoStore.email);

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DetailPage(
    title: context.l10n.personalInformation,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.l10n.fullName,
          style: TextStyle(
            fontFamily: aicaFontFamily,
            fontFamilyFallback: khmerFontFallback,
            color: aicaInk(context),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 7),
        TextField(
          controller: _name,
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
        SizedBox(height: 16),
        Text(
          context.l10n.phone,
          style: TextStyle(
            fontFamily: aicaFontFamily,
            fontFamilyFallback: khmerFontFallback,
            color: aicaInk(context),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 7),
        Container(
          height: 56,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: aicaSurface(context),
            border: Border.all(color: aicaBorder(context)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Text(
                '+855',
                style: TextStyle(
                  fontFamily: aicaFontFamily,
                  fontFamilyFallback: khmerFontFallback,
                  color: aicaInk(context),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 12),
              Container(width: 1, height: 24, color: aicaBorder(context)),
              SizedBox(width: 12),
              Flexible(
                child: Text(
                  demoStore.phone,
                  style: TextStyle(
                    fontFamily: aicaFontFamily,
                    fontFamilyFallback: khmerFontFallback,
                    color: aicaInk(context),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(
          context.l10n.emailOptional,
          style: TextStyle(
            fontFamily: aicaFontFamily,
            fontFamilyFallback: khmerFontFallback,
            color: aicaInk(context),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 7),
        TextField(
          controller: _email,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'name@example.com',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        FilledButton(
          onPressed: () {
            if (_name.text.trim().isEmpty) {
              showDemoMessage(context, context.l10n.pleaseEnterYourName);
              return;
            }
            demoStore.setProfile(_name.text.trim(), _email.text.trim());
            showDemoMessage(context, context.l10n.demoProfileSavedLocally);
          },
          child: Text(context.l10n.saveChanges),
        ),
      ],
    ),
  );
}

class NotificationPreferencesScreen extends StatefulWidget {
  const NotificationPreferencesScreen({
    super.key,
    this.permissionService = const NotificationPermissionService(),
  });

  final NotificationPermissionService permissionService;

  @override
  State<NotificationPreferencesScreen> createState() =>
      _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState
    extends State<NotificationPreferencesScreen>
    with WidgetsBindingObserver {
  NotificationPermissionState? _permissionState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refreshPermissionStatus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshPermissionStatus();
    }
  }

  Future<void> _refreshPermissionStatus() async {
    if (!widget.permissionService.isSupported) return;
    final status = await widget.permissionService.getStatus();
    if (mounted) setState(() => _permissionState = status);
  }

  Future<void> _handlePermissionAction() async {
    if (_permissionState == NotificationPermissionState.granted) return;

    if (_permissionState == NotificationPermissionState.permanentlyDenied) {
      final opened = await widget.permissionService.openSettings();
      if (!opened && mounted) {
        showDemoMessage(context, context.l10n.unableToOpenAppSettings);
      }
      return;
    }

    final status = await widget.permissionService.requestPermission();
    if (!mounted) return;
    setState(() => _permissionState = status);

    switch (status) {
      case NotificationPermissionState.granted:
        showDemoMessage(context, context.l10n.notificationsAreAllowed);
      case NotificationPermissionState.denied:
        showDemoMessage(
          context,
          context.l10n.notificationPermissionWasNotAllowedTheApp,
        );
      case NotificationPermissionState.permanentlyDenied:
        showDemoMessage(
          context,
          context.l10n.notificationsAreDisabledYouCanEnableThem,
        );
    }
  }

  String get _permissionSubtitle => switch (_permissionState) {
    NotificationPermissionState.granted => context.l10n.allowed,
    NotificationPermissionState.denied => context.l10n.notAllowed,
    NotificationPermissionState.permanentlyDenied =>
      context.l10n.enableFromAndroidAppSettings,
    null =>
      widget.permissionService.isSupported
          ? context.l10n.checkingPermission
          : context.l10n.availableOnAndroid,
  };

  Widget get _permissionAction => switch (_permissionState) {
    NotificationPermissionState.granted => Icon(
      Icons.check_circle,
      color: aicaTone(context, Color(0xFF188653)),
    ),
    NotificationPermissionState.permanentlyDenied => Text(
      context.l10n.settings,
      style: TextStyle(
        fontFamily: aicaFontFamily,
        fontFamilyFallback: khmerFontFallback,
        color: aicaBlue(context),
      ),
    ),
    NotificationPermissionState.denied => Text(
      context.l10n.enable,
      style: TextStyle(
        fontFamily: aicaFontFamily,
        fontFamilyFallback: khmerFontFallback,
        color: aicaBlue(context),
      ),
    ),
    null =>
      !widget.permissionService.isSupported
          ? const SizedBox.shrink()
          : SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
  };

  @override
  Widget build(BuildContext context) => DetailPage(
    title: context.l10n.notificationPreferences,
    child: AppPanel(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          AppMenuRow(
            icon: Icons.notifications_active_outlined,
            label: context.l10n.deviceNotifications,
            subtitle: _permissionSubtitle,
            trailing: _permissionAction,
            onTap: _permissionState == null ? null : _handlePermissionAction,
          ),
          Divider(height: 1),
          for (final (index, key)
              in demoStore.notificationPreferences.keys.indexed) ...[
            if (index > 0) Divider(height: 1),
            AppMenuRow(
              icon: Icons.notifications_none,
              label: notificationPreferenceLabel(context, key),
              trailing: Switch(
                value: demoStore.notificationPreferences[key]!,
                onChanged: (value) =>
                    setState(() => demoStore.setPreference(key, value)),
              ),
            ),
          ],
        ],
      ),
    ),
  );
}

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});
  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool _biometricPreview = true;

  @override
  Widget build(BuildContext context) => DetailPage(
    title: context.l10n.privacySecurity,
    child: Column(
      children: [
        AppPanel(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              AppMenuRow(
                icon: Icons.fingerprint,
                label: context.l10n.biometricUnlock,
                trailing: Switch(
                  value: _biometricPreview,
                  onChanged: (value) {
                    setState(() => _biometricPreview = value);
                    showDemoMessage(
                      context,
                      context.l10n.biometricUnlockIsAVisualDemoOnly,
                    );
                  },
                ),
              ),
              Divider(height: 1),
              AppMenuRow(
                icon: Icons.password,
                label: context.l10n.changeAppPin,
                onTap: () => showDemoMessage(
                  context,
                  context.l10n.appPinIsNotConfiguredInThis,
                ),
              ),
              Divider(height: 1),
              AppMenuRow(
                icon: Icons.download,
                label: context.l10n.downloadMyData,
                onTap: () => showDemoMessage(
                  context,
                  context.l10n.dataExportNeedsABackend,
                ),
              ),
              Divider(height: 1),
              AppMenuRow(
                icon: Icons.delete_outline,
                label: context.l10n.deleteAccount,
                danger: true,
                onTap: () => showDemoMessage(
                  context,
                  context.l10n.accountDeletionNeedsABackend,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 18),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: aicaTone(context, Color(0xFFEAF1FF)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(Icons.lock, color: aicaBlue(context), size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  context.l10n.yourDataIsUsedOnlyToShow,
                  style: TextStyle(
                    fontFamily: aicaFontFamily,
                    fontFamilyFallback: khmerFontFallback,
                    color: aicaBlue(context),
                    fontSize: 13,
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

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});
  @override
  Widget build(BuildContext context) => DetailPage(
    title: context.l10n.helpSupport,
    child: AppPanel(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          AppMenuRow(
            icon: Icons.quiz_outlined,
            label: context.l10n.faqs,
            onTap: () => showDemoMessage(
              context,
              context.l10n.faqsAreNotConnectedInThisDemo,
            ),
          ),
          Divider(height: 1),
          AppMenuRow(
            icon: Icons.call_outlined,
            label: context.l10n.callSupport,
            subtitle: context.l10n.demoNumber,
            onTap: () => showDemoMessage(
              context,
              context.l10n.supportNumberIsADemoPlaceholder,
            ),
          ),
          Divider(height: 1),
          AppMenuRow(
            icon: Icons.chat_outlined,
            label: context.l10n.chatWithUs,
            onTap: () =>
                showDemoMessage(context, context.l10n.chatSupportNeedsABackend),
          ),
        ],
      ),
    ),
  );
}
