// ignore_for_file: avoid_print

import 'dart:io';

Future<void> main(List<String> args) async {
  if (args.length != 1) {
    print('Usage: dart run cmd/new_locale_checker.dart <locale-code>');
    return;
  }

  final code = args[0];
  if (code.isEmpty || code.length != 2) {
    print(
      'Please provide a valid 2 character '
      'locale code e.g. (en/es).',
    );
    return;
  }

  final localeFile = File('lib/i18n/$code.json');
  if (!localeFile.existsSync()) {
    print(
      'Please create a new localization file for '
      '$code inside the i18n folder.',
    );
    return;
  }

  final supportedLocales = extractStringsInsideSingleQuotes(
    File('lib/src/models/country_localizations.dart')
        .readAsStringSync()
        .split('static const List<String> supportedLocales = [')[1]
        .split('];')[0]
        .trim(),
  );

  if (!supportedLocales.contains(code)) {
    print(
      'Please add the new localization code '
      'inside the supportedLocales list file.',
    );
    return;
  }

  final pubLocales = File('pubspec.yaml')
      .readAsStringSync()
      .split('assets/flags/')[1]
    ..split('\n');

  if (!pubLocales.contains(
    '- packages/fl_country_code_picker/i18n/$code.json',
  )) {
    print(
      'Please add the new localization code i18n file path '
      'at pubspec.yaml assets list.',
    );
    return;
  }

  print('Locale for $code was implemented correctly.');
}

List<String> extractStringsInsideSingleQuotes(String input) {
  final exp = RegExp("'([a-zA-Z]{2})'");
  final matches = exp.allMatches(input);

  final extractedStrings = <String>[];

  for (final match in matches) {
    if (match.groupCount >= 1) {
      final extracted = match.group(1);
      if (extracted != null) extractedStrings.add(extracted);
    }
  }
  return extractedStrings;
}
