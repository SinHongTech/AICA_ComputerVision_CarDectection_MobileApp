import 'package:flutter/material.dart';

const aicaFontFamily = 'Plus Jakarta Sans';
const khmerFontFallback = ['Noto Sans Khmer', 'Khmer OS', 'sans-serif'];

bool isDark(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;
Color aicaInk(BuildContext context) =>
    isDark(context) ? const Color(0xFFE6EDF5) : const Color(0xFF102A43);
Color aicaMuted(BuildContext context) =>
    isDark(context) ? const Color(0xFFAFBED0) : const Color(0xFF526579);
Color aicaBlue(BuildContext context) =>
    isDark(context) ? const Color(0xFF8BB4FF) : const Color(0xFF2563EB);
Color aicaSurface(BuildContext context) =>
    isDark(context) ? const Color(0xFF172536) : Colors.white;
Color aicaBorder(BuildContext context) =>
    isDark(context) ? const Color(0xFF3B4D63) : const Color(0xFFC9D5E2);

/// Semantic colors retain their meaning, with readable dark-mode counterparts.
Color aicaTone(BuildContext context, Color light) {
  if (!isDark(context)) return light;
  return switch (light.toARGB32()) {
    0xFFF8FAFC => const Color(0xFF0E1928),
    0xFFEAF1FF => const Color(0xFF203554),
    0xFFFDEBEC => const Color(0xFF462A34),
    0xFFFFF4D9 => const Color(0xFF403820),
    0xFFF2EAFE => const Color(0xFF37294C),
    0xFFE5F6EB => const Color(0xFF203C33),
    0xFFC32632 => const Color(0xFFFFA1A8),
    0xFF9D6B00 => const Color(0xFFFFD477),
    0xFF7542B5 => const Color(0xFFD2B0FF),
    0xFF188653 => const Color(0xFF78D8A9),
    _ => light,
  };
}
