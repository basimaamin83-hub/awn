import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ألوان مستوحاة من قوس قزح مع تباين مقروء للنصوص.
abstract final class AppColors {
  static const Color rainbowRed = Color(0xFFE53935);
  static const Color rainbowOrange = Color(0xFFFF9100);
  static const Color rainbowYellow = Color(0xFFFFC107);
  static const Color rainbowGreen = Color(0xFF00C853);
  static const Color rainbowBlue = Color(0xFF1E88E5);
  static const Color rainbowIndigo = Color(0xFF5E35B1);
  static const Color rainbowViolet = Color(0xFF8E24AA);

  static const List<Color> rainbowStrip = [
    rainbowRed,
    rainbowOrange,
    rainbowYellow,
    rainbowGreen,
    rainbowBlue,
    rainbowIndigo,
    rainbowViolet,
  ];

  static LinearGradient get rainbowBar => const LinearGradient(
        colors: rainbowStrip,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

  static LinearGradient get rainbowDiagonal => const LinearGradient(
        colors: rainbowStrip,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  /// أساس الواجهة (بنفسجي قوس قزح)
  static const Color royalBlue = rainbowViolet;
  static const Color royalBlueLight = Color(0xFFAB47BC);
  static const Color royalBluePale = Color(0xFFF3E5F5);
  static const Color royalBlueDark = Color(0xFF6A1B9A);

  static const Color cream = Color(0xFFFFFBFE);
  static const Color coral = rainbowRed;
  static const Color coralDark = Color(0xFFC62828);
  static const Color sky = rainbowBlue;

  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF5C5C7A);

  static const Color olive = royalBlue;
  static const Color oliveLight = royalBlueLight;
  static const Color olivePale = royalBluePale;
  static const Color deepTeal = royalBlueDark;
}

ThemeData buildAwnTheme({required Brightness brightness}) {
  final seed = AppColors.rainbowViolet;
  final base = ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seed,
      primary: AppColors.rainbowViolet,
      onPrimary: Colors.white,
      secondary: AppColors.rainbowBlue,
      onSecondary: Colors.white,
      tertiary: AppColors.rainbowGreen,
      onTertiary: Colors.white,
      surface: brightness == Brightness.dark ? const Color(0xFF1A1520) : AppColors.cream,
      error: AppColors.coral,
      brightness: brightness,
    ),
  );

  final textTheme = GoogleFonts.tajawalTextTheme(base.textTheme).apply(
    bodyColor: brightness == Brightness.dark ? Colors.white70 : AppColors.textPrimary,
    displayColor: brightness == Brightness.dark ? Colors.white : AppColors.textPrimary,
  );

  return base.copyWith(
    scaffoldBackgroundColor:
        brightness == Brightness.dark ? const Color(0xFF121018) : AppColors.cream,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      backgroundColor: brightness == Brightness.dark
          ? const Color(0xFF1A1520)
          : AppColors.royalBluePale,
      foregroundColor: AppColors.textPrimary,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: brightness == Brightness.dark ? const Color(0xFF231D2E) : Colors.white,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: AppColors.rainbowIndigo,
        foregroundColor: Colors.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        foregroundColor: AppColors.rainbowViolet,
        side: const BorderSide(color: AppColors.rainbowViolet, width: 1.5),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    ),
    navigationBarTheme: NavigationBarThemeData(
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      height: 72,
      indicatorColor: AppColors.rainbowYellow.withValues(alpha: 0.35),
      backgroundColor: brightness == Brightness.dark ? const Color(0xFF1E1A28) : Colors.white,
    ),
  );
}
