// lib/steps/theme_step.dart

import 'package:path/path.dart' as p;
import '../init_context.dart';
import '../init_step.dart';
import '../utils/file_writer.dart';

class ThemeStep implements InitStep {
  @override
  String get name => 'Generating theme files';

  @override
  Future<void> run(InitContext context) async {
    final themeDir = p.join(context.projectPath, 'lib', 'core', 'theme');

    await Future.wait([
      FileWriter.write(p.join(themeDir, 'app_colors.dart'), _colorsContent),
      FileWriter.write(
        p.join(themeDir, 'app_text_theme.dart'),
        _textThemeContent,
      ),
      FileWriter.write(p.join(themeDir, 'app_theme.dart'), _themeContent),
    ]);
  }

  // ─────────────────────────────────────────────────────────── colors ──────

  static const _colorsContent = '''
import 'package:flutter/material.dart';

abstract final class AppColors {
  // ── Brand ────────────────────────────────────────────────────────────────
  static const primary = Color(0xFF6750A4);
  static const onPrimary = Color(0xFFFFFFFF);
  static const primaryContainer = Color(0xFFEADDFF);
  static const onPrimaryContainer = Color(0xFF21005D);

  static const secondary = Color(0xFF625B71);
  static const onSecondary = Color(0xFFFFFFFF);
  static const secondaryContainer = Color(0xFFE8DEF8);
  static const onSecondaryContainer = Color(0xFF1D192B);

  static const tertiary = Color(0xFF7D5260);
  static const onTertiary = Color(0xFFFFFFFF);
  static const tertiaryContainer = Color(0xFFFFD8E4);
  static const onTertiaryContainer = Color(0xFF31111D);

  // ── Neutral ───────────────────────────────────────────────────────────────
  static const background = Color(0xFFFFFBFE);
  static const onBackground = Color(0xFF1C1B1F);
  static const surface = Color(0xFFFFFBFE);
  static const onSurface = Color(0xFF1C1B1F);
  static const surfaceVariant = Color(0xFFE7E0EC);
  static const onSurfaceVariant = Color(0xFF49454F);
  static const outline = Color(0xFF79747E);
  static const outlineVariant = Color(0xFFCAC4D0);

  // ── Semantic ──────────────────────────────────────────────────────────────
  static const error = Color(0xFFB3261E);
  static const onError = Color(0xFFFFFFFF);
  static const errorContainer = Color(0xFFF9DEDC);
  static const onErrorContainer = Color(0xFF410E0B);

  static const success = Color(0xFF386A20);
  static const onSuccess = Color(0xFFFFFFFF);
  static const successContainer = Color(0xFFB7F397);
  static const onSuccessContainer = Color(0xFF042100);

  static const warning = Color(0xFF7C5800);
  static const onWarning = Color(0xFFFFFFFF);
  static const warningContainer = Color(0xFFFFDEA5);
  static const onWarningContainer = Color(0xFF271900);

  // ── Dark variants ─────────────────────────────────────────────────────────
  static const darkPrimary = Color(0xFFD0BCFF);
  static const darkOnPrimary = Color(0xFF381E72);
  static const darkPrimaryContainer = Color(0xFF4F378B);
  static const darkOnPrimaryContainer = Color(0xFFEADDFF);

  static const darkSecondary = Color(0xFFCCC2DC);
  static const darkOnSecondary = Color(0xFF332D41);
  static const darkSecondaryContainer = Color(0xFF4A4458);
  static const darkOnSecondaryContainer = Color(0xFFE8DEF8);

  static const darkBackground = Color(0xFF1C1B1F);
  static const darkOnBackground = Color(0xFFE6E1E5);
  static const darkSurface = Color(0xFF1C1B1F);
  static const darkOnSurface = Color(0xFFE6E1E5);
  static const darkSurfaceVariant = Color(0xFF49454F);
  static const darkOnSurfaceVariant = Color(0xFFCAC4D0);
  static const darkOutline = Color(0xFF938F99);
  static const darkOutlineVariant = Color(0xFF49454F);

  static const darkError = Color(0xFFF2B8B5);
  static const darkOnError = Color(0xFF601410);
  static const darkErrorContainer = Color(0xFF8C1D18);
  static const darkOnErrorContainer = Color(0xFFF9DEDC);
}
''';

  // ────────────────────────────────────────────────────── text theme ────────

  static const _textThemeContent = '''
import 'package:flutter/material.dart';

abstract final class AppTextTheme {
  static TextTheme get light => _base(Colors.black);
  static TextTheme get dark => _base(Colors.white);

  static TextTheme _base(Color color) => TextTheme(
        // ── Display ──────────────────────────────────────────────────────────
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          color: color,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w400,
          color: color,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          color: color,
        ),

        // ── Headline ─────────────────────────────────────────────────────────
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: color,
        ),

        // ── Title ─────────────────────────────────────────────────────────────
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: color,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          color: color,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: color,
        ),

        // ── Body ──────────────────────────────────────────────────────────────
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          color: color,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: color,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: color,
        ),

        // ── Label ─────────────────────────────────────────────────────────────
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: color,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: color,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: color,
        ),
      );
}
''';

  // ──────────────────────────────────────────────────────── theme data ──────

  static const _themeContent = '''
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_theme.dart';

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        textTheme: AppTextTheme.light,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: AppColors.onPrimary,
          primaryContainer: AppColors.primaryContainer,
          onPrimaryContainer: AppColors.onPrimaryContainer,
          secondary: AppColors.secondary,
          onSecondary: AppColors.onSecondary,
          secondaryContainer: AppColors.secondaryContainer,
          onSecondaryContainer: AppColors.onSecondaryContainer,
          tertiary: AppColors.tertiary,
          onTertiary: AppColors.onTertiary,
          tertiaryContainer: AppColors.tertiaryContainer,
          onTertiaryContainer: AppColors.onTertiaryContainer,
          error: AppColors.error,
          onError: AppColors.onError,
          errorContainer: AppColors.errorContainer,
          onErrorContainer: AppColors.onErrorContainer,
          surface: AppColors.surface,
          onSurface: AppColors.onSurface,
          surfaceContainerHighest: AppColors.surfaceVariant,
          onSurfaceVariant: AppColors.onSurfaceVariant,
          outline: AppColors.outline,
          outlineVariant: AppColors.outlineVariant,
          shadow: Colors.black,
          scrim: Colors.black,
          inverseSurface: AppColors.onBackground,
          onInverseSurface: AppColors.background,
          inversePrimary: AppColors.darkPrimary,
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        textTheme: AppTextTheme.dark,
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: AppColors.darkPrimary,
          onPrimary: AppColors.darkOnPrimary,
          primaryContainer: AppColors.darkPrimaryContainer,
          onPrimaryContainer: AppColors.darkOnPrimaryContainer,
          secondary: AppColors.darkSecondary,
          onSecondary: AppColors.darkOnSecondary,
          secondaryContainer: AppColors.darkSecondaryContainer,
          onSecondaryContainer: AppColors.darkOnSecondaryContainer,
          tertiary: AppColors.tertiary,
          onTertiary: AppColors.onTertiary,
          tertiaryContainer: AppColors.tertiaryContainer,
          onTertiaryContainer: AppColors.onTertiaryContainer,
          error: AppColors.darkError,
          onError: AppColors.darkOnError,
          errorContainer: AppColors.darkErrorContainer,
          onErrorContainer: AppColors.darkOnErrorContainer,
          surface: AppColors.darkSurface,
          onSurface: AppColors.darkOnSurface,
          surfaceContainerHighest: AppColors.darkSurfaceVariant,
          onSurfaceVariant: AppColors.darkOnSurfaceVariant,
          outline: AppColors.darkOutline,
          outlineVariant: AppColors.darkOutlineVariant,
          shadow: Colors.black,
          scrim: Colors.black,
          inverseSurface: AppColors.darkOnBackground,
          onInverseSurface: AppColors.darkBackground,
          inversePrimary: AppColors.primary,
        ),
      );
}
''';
}
