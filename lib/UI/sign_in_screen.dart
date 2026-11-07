import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

import '../l10n/l10n_context.dart';

import 'package:flutter/services.dart';

import '../data/auth/user_repository.dart';
import 'verify_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _phoneController = TextEditingController();
  bool _consented = false;
  bool _checkingAccount = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _sendCode() async {
    final digits = _phoneController.text.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 8 || digits.length > 9) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.enterAValidCambodianPhoneNumber)),
      );
      return;
    }
    if (!_consented) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.pleaseAgreeToTheTermsBeforeContinuing),
        ),
      );
      return;
    }

    setState(() => _checkingAccount = true);
    try {
      final user = await appUserRepository.findByPhone(digits);
      if (!mounted) return;
      setState(() => _checkingAccount = false);
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.noTestAccountFoundForThisNumber)),
        );
        return;
      }

      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => VerifyScreen(phone: user.phone),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _checkingAccount = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(context.l10n.unableToSignIn)));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: true,
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 390),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              32,
              24,
              MediaQuery.sizeOf(context).height < 700 ? 8 : 32,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 56,
                            height: 56,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xFF102A43),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              Icons.traffic_rounded,
                              color: Color(0xFF60A5FA),
                              size: 34,
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        Text(
                          context.l10n.welcomeBack,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(height: 8),
                        Text(
                          context.l10n.signInOrCreateAnAccountWith,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(height: 32),
                        Text(
                          context.l10n.phoneNumber,
                          style: TextStyle(
                            fontFamily: aicaFontFamily,
                            fontFamilyFallback: khmerFontFallback,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: aicaInk(context),
                          ),
                        ),
                        SizedBox(height: 6),
                        TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(9),
                          ],
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 16, right: 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
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
                                  SizedBox(
                                    height: 25,
                                    child: VerticalDivider(width: 1),
                                  ),
                                ],
                              ),
                            ),
                            hintText: '12 345 678',
                            filled: true,
                            fillColor: aicaSurface(context),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: aicaBorder(context),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: aicaBorder(context),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        InkWell(
                          onTap: () => setState(() => _consented = !_consented),
                          borderRadius: BorderRadius.circular(8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 2),
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: _consented
                                      ? aicaBlue(context)
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: aicaBlue(context),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: _consented
                                    ? Icon(
                                        Icons.check,
                                        size: 16,
                                        color: aicaSurface(context),
                                      )
                                    : null,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  context.l10n.iAgreeToTheTermsAndThe,
                                  style: TextStyle(
                                    fontFamily: aicaFontFamily,
                                    fontFamilyFallback: khmerFontFallback,
                                    color: aicaMuted(context),
                                    fontSize: 13,
                                    height: 1.45,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        FilledButton.icon(
                          onPressed: _checkingAccount ? null : _sendCode,
                          icon: _checkingAccount
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.sms_outlined),
                          label: Text(context.l10n.sendCode),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.lock,
                              size: 14,
                              color: aicaMuted(context),
                            ),
                            SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                context
                                    .l10n
                                    .encryptedNotAnOfficialGovernmentApp,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: aicaFontFamily,
                                  fontFamilyFallback: khmerFontFallback,
                                  color: aicaMuted(context),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
