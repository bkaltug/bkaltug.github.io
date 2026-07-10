import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'palette.dart';

BorderSide? _focusSide(Set<WidgetState> states, {BorderSide? idle}) =>
    states.contains(WidgetState.focused)
    ? const BorderSide(color: Palette.textPrimary, width: 1.5)
    : idle;

/// App-wide dark theme. Scaffolds are transparent so the aurora backdrop in
/// the shell shows through on every page.
ThemeData buildAppTheme() {
  final scheme =
      ColorScheme.fromSeed(
        seedColor: Palette.accentBlue,
        brightness: Brightness.dark,
      ).copyWith(
        primary: Palette.accentBlue,
        surface: Palette.background,
        onSurface: Palette.textPrimary,
      );
  final base = ThemeData(colorScheme: scheme);

  return base.copyWith(
    scaffoldBackgroundColor: Colors.transparent,
    textTheme: GoogleFonts.interTextTheme(
      base.textTheme,
    ).apply(bodyColor: Palette.textPrimary, displayColor: Palette.textPrimary),
    filledButtonTheme: FilledButtonThemeData(
      style:
          FilledButton.styleFrom(
            backgroundColor: Palette.accentBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
            textStyle: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ).copyWith(
            // Visible keyboard focus ring on filled buttons.
            side: WidgetStateProperty.resolveWith(_focusSide),
          ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style:
          OutlinedButton.styleFrom(
            foregroundColor: Palette.textPrimary,
            textStyle: GoogleFonts.inter(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
            ),
          ).copyWith(
            side: WidgetStateProperty.resolveWith(
              (states) =>
                  _focusSide(states, idle: const BorderSide(color: Color(0x33FFFFFF))),
            ),
          ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(side: WidgetStateProperty.resolveWith(_focusSide)),
    ),
  );
}
