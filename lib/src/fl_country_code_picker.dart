import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';

/// {@template fl_country_code_picker}
/// A Flutter package for showing a modal that contains country dial code.
///
/// The user can also search for the available codes and
/// select right from the modal.
/// {@endtemplate}
class FlCountryCodePicker {
  /// {@macro fl_country_code_picker}
  const FlCountryCodePicker({
    required this.context,
    this.pickerMaxHeight = 300,
    this.pickerMinHeight = 150,
    this.isFullScreen = false,
  });

  /// In order to be accessible, we need to provide [BuildContext].
  final BuildContext context;

  /// The max height of the country code picker.
  final double pickerMaxHeight;

  /// The min height of the country code picker.
  final double pickerMinHeight;

  /// Shows the country code picker on full screen.
  ///
  /// This overrides the [pickerMaxHeight] property.
  final bool isFullScreen;

  /// Shows the [CountryCodePickerModal] modal.
  Future<CountryCode?> showPicker() async {
    final country = await showModal<CountryCode?>(
      context: context,
      isFullScreen: isFullScreen,
      maxHeight: pickerMaxHeight,
      minHeight: pickerMinHeight,
      child: const CountryCodePickerModal(),
    );
    return country;
  }

  /// Gets all of the available country codes.
  List<CountryCode> countryCodes() {
    final countryCodes = List<CountryCode>.from(
      codes.map<CountryCode>(CountryCode.fromMap),
    );
    return countryCodes;
  }
}
