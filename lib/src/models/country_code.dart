import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';

/// {@template country_code}
/// A single country code item.
///
/// Contains a [name], [code], and [dialCode].
///
/// [CountryCode]s are immutable and can be copied using [copyWith] and
/// which are basically from [List] of [Map<String, String>] that are
/// converted using the [CountryCode.fromMap] method.
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

  /// Gets [CountryCode] based on the given [dialCode].
  static CountryCode? fromDialCode(String dialCode) {
    final allCountryCodes = codes.map(CountryCode.fromMap).toList();
    final index = allCountryCodes.indexWhere((c) => c.dialCode == dialCode);
    if (index == -1) return null;
    return allCountryCodes[index];
  }

  /// Gets [CountryCode] based on the given [code].
  static CountryCode? fromCode(String code) {
    final allCountryCodes = codes.map(CountryCode.fromMap).toList();
    final index = allCountryCodes.indexWhere((c) => c.code == code);
    if (index == -1) return null;
    return allCountryCodes[index];
  }

  /// Gets [CountryCode] based on the given [name].
  static CountryCode? fromName(String name) {
    final allCountryCodes = codes.map(CountryCode.fromMap).toList();
    final index = allCountryCodes.indexWhere((c) => c.name == name);
    if (index == -1) return null;
    return allCountryCodes[index];
  }

  /// The name of the country.
  ///
  /// Cannot be empty.
  final String name;

  /// {@template code}
  /// The 2 character ISO code of the country.
  ///
  /// Based from: https://countrycode.org/
  /// {@endtemplate}
  final String code;

  /// {@template dial_code}
  /// The country dial code.
  ///
  /// By convention, international telephone numbers are
  /// represented by prefixing the country code with a plus sign (+).
  ///
  /// This properties return [String] value like this:
  /// `+1` for US.
  ///
  /// For more info: https://en.wikipedia.org/wiki/List_of_country_calling_codes
  /// {@endtemplate}
  final String dialCode;

  /// Convenient getter for localized version of this country code.
  CountryCode localize(BuildContext context) => copyWith(
        name: CountryLocalizations.of(context)?.translation(code),
      );

  /// Uri of this [CountryCode] located at package's directory to supply
  /// at [Image] widget if you're going to get the raw flag image.
  ///
  /// Don't forget to use the `flagImagePackage` to prevent [OS not found]
  /// error because it is inside the package's bundle.
  ///
  /// ### Example:
  /// ```dart
  ///      Image.asset(
  ///        fit: fit,
  ///        width: width,
  ///        countryCode.flagUri,
  ///        alignment: alignment,
  ///        package: countryCode.flagImagePackage,
  ///      );
  /// ```
  String get flagUri => 'assets/flags/${code.toLowerCase()}.png';

  /// Package to supply at [Image] widget if you're going to get
  /// the raw flag image.
  String get flagImagePackage => 'fl_country_code_picker';

  /// Gets the widget that can be used on displaying
  /// the selected country's flag.
  CountryCodeFlagWidget flagImage({
    BoxFit? fit,
    double width = 32,
    AlignmentGeometry alignment = Alignment.center,
  }) =>
      CountryCodeFlagWidget(
        fit: fit,
        width: width,
        countryCode: this,
        alignment: alignment,
      );

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

  /// Returns a copy of this [CountryCode] with the given values updated.
  CountryCode copyWith({
    String? name,
    String? code,
    String? dialCode,
  }) {
    return CountryCode(
      name: name ?? this.name,
      code: code ?? this.code,
      dialCode: dialCode ?? this.dialCode,
    );
  }
}

/// {@template country_code_flag}
/// Widget that can be used on retrieving the flag's image.
/// {@endtemplate}
class CountryCodeFlagWidget extends StatelessWidget {
  /// {@macro country_code_flag}
  const CountryCodeFlagWidget({
    required this.width,
    required this.alignment,
    required this.countryCode,
    Key? key,
    this.fit,
  }) : super(key: key);

  /// The associated [CountryCode] for display.
  final CountryCode countryCode;

  /// BoxFit property of the widget.
  final BoxFit? fit;

  /// Alignment property of the widget.
  final AlignmentGeometry alignment;

  /// Width property of the widget.
  final double width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      countryCode.flagUri,
      fit: fit,
      width: width,
      alignment: alignment,
      package: countryCode.flagImagePackage,
    );
  }
}
