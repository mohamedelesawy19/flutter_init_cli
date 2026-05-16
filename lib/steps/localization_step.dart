import 'package:path/path.dart' as p;
import '../init_context.dart';
import '../init_step.dart';
import '../utils/file_writer.dart';

class LocalizationStep implements InitStep {
  @override
  String get name => 'Configuring Localization';

  @override
  Future<void> run(InitContext context) async {
    final localizationDir = p.join(
      context.projectPath,
      'lib',
      'src',
      'config',
      'localization',
    );

    await Future.wait([
      // ── l10n.yaml (root) ────────────────────────────────────────────────────
      FileWriter.write(
        p.join(context.projectPath, 'l10n.yaml'),
        _l10nYaml,
        overwrite: true,
      ),

      // ── localization_delegate.dart ──────────────────────────────────────────
      FileWriter.write(
        p.join(localizationDir, 'localization_delegate.dart'),
        _delegateContent(),
        overwrite: true,
      ),

      // ── localization_helpers.dart ───────────────────────────────────────────
      FileWriter.write(
        p.join(localizationDir, 'localization_helpers.dart'),
        _helpersContent(),
        overwrite: true,
      ),

      // ── app_en.arb ──────────────────────────────────────────────────────────
      FileWriter.write(
        p.join(localizationDir, 'l10n', 'app_en.arb'),
        _arbEn,
        overwrite: false, // don't overwrite existing translations
      ),

      // ── app_ar.arb ──────────────────────────────────────────────────────────
      FileWriter.write(
        p.join(localizationDir, 'l10n', 'app_ar.arb'),
        _arbAr,
        overwrite: false,
      ),
    ]);
  }

  // ── l10n.yaml ──────────────────────────────────────────────────────────────

  static const _l10nYaml = '''
arb-dir: lib/src/config/localization/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
output-dir: lib/src/config/localization/generated
preferred-supported-locales: ["ar", "en"]
''';

  // ── localization_delegate.dart ─────────────────────────────────────────────

  static String _delegateContent() => '''
// Package imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Project imports:
import '/src/config/localization/generated/app_localizations.dart';

// Custom localization delegate for the app.
class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.supportedLocales.contains(locale);

  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;
}

// Central localization configuration — pass these directly to [MaterialApp].
class LocalizationConfig {
  const LocalizationConfig._();

  static const List<Locale> supportedLocales = [
    Locale('en'), // English
    Locale('ar'), // Arabic
  ];

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  // Returns the device locale when supported, otherwise falls back to Arabic.
  static Locale getDeviceLocale() {
    final deviceLocale = PlatformDispatcher.instance.locale;
    if (supportedLocales.contains(deviceLocale)) return deviceLocale;
    return const Locale('ar');
  }

  // Returns `true` when [locale] uses a right-to-left script.
  static bool isRTL(Locale locale) => locale.languageCode == 'ar';

  // Returns the [TextDirection] for [locale].
  static TextDirection getTextDirection(Locale locale) =>
      isRTL(locale) ? TextDirection.rtl : TextDirection.ltr;
}
''';

  // ── localization_helpers.dart ──────────────────────────────────────────────

  static String _helpersContent() => '''
// Package imports:
import 'package:flutter/material.dart';

// Project imports:
import '/src/config/localization/generated/app_localizations.dart';

// Convenience extensions on [BuildContext] for localization.
extension LocalizationExtension on BuildContext {
  // Short-hand accessor for [AppLocalizations].
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  // The active [Locale] for this context.
  Locale get locale => Localizations.localeOf(this);

  // `true` when the current locale uses a right-to-left script.
  bool get isRTL => locale.languageCode == 'ar';

  // The [TextDirection] derived from the current locale.
  TextDirection get textDirection =>
      isRTL ? TextDirection.rtl : TextDirection.ltr;
}
''';

  // ── ARB files ──────────────────────────────────────────────────────────────

  static const _arbEn = '''
{
  "@@locale": "en",

  "appName": "App Name",
  "@appName": {
    "description": "The name of the application"
  }
}
''';

  static const _arbAr = '''
{
  "@@locale": "ar",

  "appName": "اسم التطبيق",
  "@appName": {
    "description": "اسم التطبيق"
  }
}
''';
}
