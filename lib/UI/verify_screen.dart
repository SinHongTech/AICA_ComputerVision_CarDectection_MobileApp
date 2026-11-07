import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

import '../l10n/l10n_context.dart';

import 'package:flutter/services.dart';

import '../data/auth/user_repository.dart';
import '../data/demo_store.dart';
import 'app_shell.dart';
import 'widgets/app_components.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key, required this.phone});
  final String phone;

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _code = TextEditingController();
  bool _isVerifying = false;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _verify() async {
    if (_code.text.length != 6 || _isVerifying) return;

    setState(() => _isVerifying = true);
    try {
      final user = await appUserRepository.verifyCode(widget.phone, _code.text);
      if (!mounted) return;

      if (user == null) {
        setState(() => _isVerifying = false);
        showDemoMessage(context, context.l10n.invalidVerificationCode);
        return;
      }

      await demoStore.signIn(user);
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (_) => AppShell()),
        (_) => false,
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _isVerifying = false);
      showDemoMessage(context, context.l10n.unableToSignIn);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 390),
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 12, 24, 32),
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
                          child: SizedBox(
                            width: 44,
                            height: 44,
                            child: IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: Icon(
                                Icons.arrow_back,
                                color: aicaInk(context),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          context.l10n.verifyYourNumber,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(height: 8),
                        Text(
                          context.l10n.codeSent(widget.phone),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(height: 32),
                        Stack(
                          children: [
                            Row(
                              children: List.generate(6, (index) {
                                final focused = _code.text.length == index;
                                final value = index < _code.text.length
                                    ? _code.text[index]
                                    : '';
                                return Expanded(
                                  child: Container(
                                    height: 60,
                                    margin: EdgeInsets.only(
                                      right: index == 5 ? 0 : 8,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: aicaSurface(context),
                                      border: Border.all(
                                        color: focused
                                            ? aicaBlue(context)
                                            : aicaBorder(context),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontFamily: aicaFontFamily,
                                        fontFamilyFallback: khmerFontFallback,
                                        color: aicaInk(context),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            Positioned.fill(
                              child: TextField(
                                controller: _code,
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                autofillHints: const [
                                  AutofillHints.oneTimeCode,
                                ],
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(6),
                                ],
                                onChanged: (_) => setState(() {}),
                                onSubmitted: (_) => _verify(),
                                decoration: InputDecoration(
                                  filled: false,
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                style: TextStyle(
                                  fontFamily: aicaFontFamily,
                                  fontFamilyFallback: khmerFontFallback,
                                  color: Colors.transparent,
                                ),
                                cursorColor: Colors.transparent,
                                showCursor: false,
                                enableInteractiveSelection: false,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Text(
                          context.l10n.resendCodeIn030,
                          style: TextStyle(
                            fontFamily: aicaFontFamily,
                            fontFamilyFallback: khmerFontFallback,
                            color: aicaMuted(context),
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        FilledButton(
                          onPressed: _code.text.length == 6 && !_isVerifying
                              ? _verify
                              : null,
                          style: FilledButton.styleFrom(
                            disabledBackgroundColor: aicaBlue(context)
                                .withValues(alpha: .45),
                            disabledForegroundColor: Colors.white.withValues(
                              alpha: .75,
                            ),
                          ),
                          child: Text(context.l10n.verifyContinue),
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
