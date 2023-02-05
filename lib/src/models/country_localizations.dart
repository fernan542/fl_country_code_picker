import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as svc;

/// Importable list of supported locales.
const List<String> supportedLocales = [
  'af',
  'am',
  'ar',
  'az',
  'be',
  'bg',
  'bn',
  'bs',
  'ca',
  'cs',
  'da',
  'de',
  'el',
  'en',
  'es',
  'et',
  'fa',
  'fi',
  'fr',
  'gl',
  'ha',
  'he',
  'hi',
  'hr',
  'hu',
  'hy',
  'id',
  'is',
  'it',
  'ja',
  'ka',
  'kk',
  'km',
  'ko',
  'ku',
  'ky',
  'lt',
  'lv',
  'mk',
  'ml',
  'mn',
  'ms',
  'nb',
  'nl',
  'nn',
  'no',
  'pl',
  'ps',
  'pt',
  'ro',
  'ru',
  'sd',
  'sk',
  'sl',
  'so',
  'sq',
  'sr',
  'sv',
  'ta',
  'tg',
  'th',
  'tk',
  'tr',
  'tt',
  'uk',
  'ug',
  'ur',
  'uz',
  'vi',
  'zh',
];

/// {@template country_localizations}
/// Localization class that contains the different country name strings
/// translated into the locales that the package supports.
///
/// You can read more at:
/// * [Flutter Internationalization](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)
/// * [Defining a class for the app's localized resources](https://docs.flutter.dev/development/accessibility-and-localization/internationalization#defining-a-class-for-the-apps-localized-resources)
/// {@endtemplate}
class CountryLocalizations {
  /// {@macro country_localizations}
  CountryLocalizations(this.locale);

  /// An identifier used to select a user's language and formatting preferences.
  final Locale locale;

  /// Reference for lookup objects that contain collections of localized values.
  static CountryLocalizations of(BuildContext context) {
    return Localizations.of<CountryLocalizations>(
      context,
      CountryLocalizations,
    )!;
  }

  /// Delegate to access defined localized resources from this package.
  static const LocalizationsDelegate<CountryLocalizations> delegate =
      _CountryLocalizationsDelegate();

  late final Map<String, String> _localizedCountries;

  /// Loads the localized country values from supported language codes.
  Future<void> load() async {
    final rawJson = await svc.rootBundle.loadString(
      'packages/fl_country_code_picker/i18n/${locale.languageCode}.json',
    );

    final jsonMap = Map<String, String>.from(
      json.decode(rawJson) as Map<String, dynamic>,
    );

    _localizedCountries = jsonMap.map<String, String>(MapEntry.new);
  }

  /// Gets all of the available languages.
  List<String> languages() => _localizedCountries.keys.toList();

  /// Convenient getter for translation.
  ///
  /// Returns a `'Unknown Country` value if country code was not found.
  String translation(String countryCode) =>
      _localizedCountries[countryCode] ?? 'Unknown Country';
}

/// {@template country_localizations_delagate}
/// A factory for a set of localized resources of [CountryLocalizations],
/// to be loaded by a Localizations widget.
///
/// Copied from [LocalizationsDelegate](https://api.flutter.dev/flutter/widgets/LocalizationsDelegate-class.html).
/// {@endtemplate}
class _CountryLocalizationsDelegate
    extends LocalizationsDelegate<CountryLocalizations> {
  /// {@macro country_localizations_delagate}
  const _CountryLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      supportedLocales.contains(locale.languageCode);

  @override
  Future<CountryLocalizations> load(Locale locale) async {
    // Load/reload the current localizations value based on current
    // selected locale.
    final localizations = CountryLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_CountryLocalizationsDelegate old) => false;
}
