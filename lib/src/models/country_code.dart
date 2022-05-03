import 'package:flutter/material.dart';

/// {@template country_code}
/// A single country code item.
///
/// Contains a [name], [code], and [dialCode].
///
/// [CountryCode]s are basically from [List] of [Map<String, String>]
/// and converted using the [CountryCode.fromMap] method.
///
/// You can also get the widget that contains the [CountryCode]'s flag image
/// by calling the [flagImage] getter method.
/// {@endtemplate}
@immutable
class CountryCode {
  /// {@macro country_code}
  const CountryCode({
    required this.name,
    required this.code,
    required this.dialCode,
  });

  /// Converts the country code from map to the actual item.
  factory CountryCode.fromMap(Map<String, dynamic> map) {
    return CountryCode(
      name: map['name'] as String? ?? 'United States',
      code: map['code'] as String? ?? 'US',
      dialCode: map['dial_code'] as String? ?? '+1',
    );
  }

  /// The name of the country.
  ///
  /// Cannot be empty.
  final String name;

  /// The 2 character ISO code of the country.
  ///
  /// Based from: https://countrycode.org/
  final String code;

  /// The country dial code.
  ///
  /// By convention, international telephone numbers are
  /// represented by prefixing the country code with a plus sign (+).
  ///
  /// This properties return [String] value like this:
  /// `+1` for US.
  ///
  /// For more info: https://en.wikipedia.org/wiki/List_of_country_calling_codes
  final String dialCode;

  String get _flagUri => 'assets/flags/${code.toLowerCase()}.png';

  /// Gets the widget that can be used on displaying
  /// the selected country's flag.
  Widget get flagImage => CountryCodeFlag(flagUri: _flagUri);

  @override
  String toString() =>
      ''' CountryCode: { name: $name, code: $code, dialCode: $dialCode } ''';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountryCode &&
        other.name == name &&
        other.code == code &&
        other.dialCode == dialCode;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode ^ dialCode.hashCode;
}

/// {@template country_code_flag}
/// Widget that can be used on retrieving the flag's image.
/// {@endtemplate}
class CountryCodeFlag extends StatelessWidget {
  /// {@macro country_code_flag}
  const CountryCodeFlag({
    Key? key,
    required this.flagUri,
  }) : super(key: key);

  /// The associated relative path of the flag's asset.
  final String flagUri;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      flagUri,
      package: 'fl_country_code_picker',
      width: 32,
    );
  }
}
