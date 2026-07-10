import 'package:flutter/material.dart';

/// "Aurora Noir" color tokens.
abstract final class Palette {
  static const Color background = Color(0xFF06070C);
  static const Color textPrimary = Color(0xFFF2F4F8);
  static const Color textSecondary = Color(0xFF98A0B3);

  static const Color accentRed = Color(0xFFFF3B5C);
  static const Color accentBlue = Color(0xFF4D7CFE);
  static const Color accentPurple = Color(0xFF9A5CFF);

  /// Glass card surfaces: white at 5% fill with a white 10% border.
  static const Color cardFill = Color(0x0DFFFFFF);
  static const Color cardBorder = Color(0x1AFFFFFF);
}
