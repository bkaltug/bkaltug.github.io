import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'palette.dart';

/// "Aurora Noir" type ramp: Space Grotesk for display/headings, Inter for body.
abstract final class AppType {
  /// Large display text (page titles, the landing name). Slightly tight tracking.
  static TextStyle display({
    double size = 40,
    FontWeight weight = FontWeight.w700,
    Color color = Palette.textPrimary,
  }) => GoogleFonts.spaceGrotesk(
    fontSize: size,
    fontWeight: weight,
    letterSpacing: size * -0.02,
    height: 1.08,
    color: color,
  );

  /// Card and section headings.
  static TextStyle heading({
    double size = 20,
    FontWeight weight = FontWeight.w600,
    Color color = Palette.textPrimary,
  }) => GoogleFonts.spaceGrotesk(
    fontSize: size,
    fontWeight: weight,
    letterSpacing: -0.3,
    height: 1.25,
    color: color,
  );

  /// Body copy.
  static TextStyle body({
    double size = 15,
    FontWeight weight = FontWeight.w400,
    Color color = Palette.textSecondary,
    double height = 1.55,
  }) => GoogleFonts.inter(
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
  );

  /// 12px uppercase overline with +3px tracking. Pass uppercase text.
  static TextStyle overline({Color color = Palette.textSecondary}) =>
      GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 3,
        color: color,
      );

  /// Small chip / pill labels.
  static TextStyle chip({double size = 12.5, Color color = Palette.textSecondary}) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.3,
      );
}
