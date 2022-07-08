import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';

const _defaultIcon = Icon(Icons.favorite, color: Colors.red);

/// {@template fl_country_code_picker}
/// A Flutter package for showing a modal that contains country dial code.
///
/// The user can also search for the available codes and
/// select right from the modal.
/// {@endtemplate}
class FlCountryCodePicker {
  /// {@macro fl_country_code_picker}
  const FlCountryCodePicker({
    this.favorites = const [],
    this.filteredCountries = const [],
    this.favoriteIcon = _defaultIcon,
    this.showSearchBar = true,
  });

  /// {@template favorites}
  /// Favorite [CountryCode]s that can be shown at the top of the list.
  ///
  /// Should supply the 2 character ISO code of the country.
  ///
  /// Based from: https://countrycode.org/
  /// {@endtemplate}
  final List<String> favorites;

  /// Adds all favorites to the list.
  void addFavorites(List<String> countries) => favorites.addAll(countries);

  /// {@template filtered_countries}
  /// Filters all of the [CountryCode]s available and only show the codes that
  /// are existing in this list.
  /// {@endtemplate}
  final List<String> filteredCountries;

  /// Adds all of filtered countries to the list.
  void addFilteredCountries(List<String> countries) =>
      filteredCountries.addAll(filteredCountries);

  /// {@template favorite_icon}
  /// Custom icon of favorite countries.
  ///
  /// <i class="material-icons md-36">favorite</i> &#x2014;  Defaults to `Icons.favorite`
  /// {@endtemplate}
  final Icon favoriteIcon;

  /// {@template show_search_bar}
  /// An optional argument for showing search bar.
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool showSearchBar;

  /// Shows the [CountryCodePickerModal] modal.
  ///
  /// Returns the selected [CountryCode] by the user.
  Future<CountryCode?> showPicker({
    required BuildContext context,
    bool isFullScreen = false,
    double pickerMinHeight = 150,
    double pickerMaxHeight = 500,
  }) async {
    final country = await showModal<CountryCode?>(
      context: context,
      isFullScreen: isFullScreen,
      maxHeight: pickerMaxHeight,
      minHeight: pickerMinHeight,
      customIcon: favoriteIcon,
      favorites: favorites,
      filteredCountries: filteredCountries,
      showSearchBar: showSearchBar,
    );
    return country;
  }

  /// Gets all of the available country codes.
  List<CountryCode> get countryCodes => List<CountryCode>.from(
        codes.map<CountryCode>(CountryCode.fromMap),
      );
}
