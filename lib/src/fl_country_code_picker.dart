import 'dart:ui' as ui;

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:fl_country_code_picker/src/constants.dart';
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
    this.title,
    this.defaultAppbarBackgroundColor = Colors.white,
    this.defaultAppbarForegroundColor = Colors.black,
    this.defaultAppbarCloseIconBackgroundColor =
        const Color.fromARGB(255, 224, 224, 224),
    this.defaultAppbarText = 'Select Country Code',
    this.defaultAppbarCloseIcon = Icons.clear_rounded,
    this.localize = true,
    this.horizontalTitleGap,
    this.searchBarDecoration,
    this.showDialCode = true,
    this.showSearchBar = true,
    this.favorites = const [],
    this.filteredCountries = const [],
    this.favoritesIcon,
    this.countryTextStyle,
    this.dialCodeTextStyle,
    this.searchBarTextStyle,
  });

  /// {@template favorites_icon}
  /// Custom icon of favorite countries.
  ///
  /// <i class="material-icons md-36">favorite</i> &#x2014;
  /// Defaults to `Icons.favorite`
  /// {@endtemplate}
  final Icon? favoritesIcon;

  /// {@template horizontal_title_gap}
  /// Horizontal space between flag, country name, and trailing icon.
  /// {@endtemplate}
  final double? horizontalTitleGap;

  /// {@template show_search_bar}
  /// An optional argument for showing search bar.
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool showSearchBar;

  /// {@template show_dial_code}
  /// An optional argument for showing dial code at country tiles.
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool showDialCode;

  /// {@template title}
  /// Can be used to customize the title of the country code picker modal.
  ///
  /// If null, defaults to a Sliver App Bar
  /// {@endtemplate}
  final Widget? title;

  /// {@template default_appbar_background_color}
  /// Can be used to customize the background color of the default appbar.
  /// {@endtemplate}
  final Color defaultAppbarBackgroundColor;

  /// {@template default_appbar_foreground_color}
  /// Can be used to customize the foreground color of the default appbar.
  /// Color of icon and text.
  /// {@endtemplate}
  final Color defaultAppbarForegroundColor;

  /// {@template default_appbar_close_icon_background_color}
  /// Can be used to customize the background color of the close icon.
  /// {@endtemplate}
  final Color defaultAppbarCloseIconBackgroundColor;

  /// {@template default_appbar_text}
  /// It is the text of the default appbar.
  /// {@endtemplate}
  final String defaultAppbarText;

  /// {@template default_appbar_close_icon}
  /// It is the close icon of the default appbar.
  /// {@endtemplate}
  final IconData defaultAppbarCloseIcon;

  /// {@template search_bar_decoration}
  /// Can be used to customize the appearance of search bar.
  /// {@endtemplate}
  final InputDecoration? searchBarDecoration;

  /// {@template localize}
  /// An optional argument for localizing the country names based on
  /// device's current selected Language (country/region).
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool localize;

  /// {@template country_text_style}
  /// Optional parameter to customize the text style of the country names.
  ///
  /// If null, defaults to the labelLarge text style from the current [Theme].
  /// {@endtemplate}
  final TextStyle? countryTextStyle;

  /// {@template dial_code_text_style}
  /// Optional parameter to customize the appearance of the country dial codes.
  ///
  /// If null, defaults to the titleMedium text style from the current [Theme].
  /// {@endtemplate}
  final TextStyle? dialCodeTextStyle;

  /// {@template search_bar_text_style}
  /// Optional parameter to customize the appearance of the search bar.
  /// {@endtemplate}
  final TextStyle? searchBarTextStyle;

  /// Convenient getter for all of the available country codes.
  List<CountryCode> get countryCodes => List<CountryCode>.from(
        codes.map<CountryCode>(CountryCode.fromMap),
      );

  /// {@template favorites}
  /// Favorite [CountryCode]s that can be shown at the top of the list.
  ///
  /// Should supply the 2 character ISO code of the country.
  ///
  /// Based from: https://countrycode.org/
  /// {@endtemplate}
  final List<String> favorites;

  /// {@template filtered_countries}
  /// Filters all of the [CountryCode]s available and only show the codes that
  /// are existing in this list.
  /// {@endtemplate}
  final List<String> filteredCountries;

  /// Adds all favorites to the list.
  void addFavorites(List<String> countries) => favorites.addAll(countries);

  /// Adds all of filtered countries to the list.
  void addFilteredCountries(List<String> countries) =>
      filteredCountries.addAll(filteredCountries);

  /// Shows the [CountryCodePickerModal] modal.
  ///
  /// If `scrollToDeviceLocale` was set to `true`, it will override the
  /// value from `initialSelectedLocale` parameter.
  ///
  /// Returns the selected [CountryCode].
  Future<CountryCode?> showPicker({
    required BuildContext context,
    bool fullScreen = false,
    ShapeBorder shape = kShape,
    double pickerMinHeight = 150,
    double pickerMaxHeight = 500,
    double pickerMaxWidth = double.infinity,
    String? initialSelectedLocale,
    bool scrollToDeviceLocale = false,
    Color barrierColor = kBarrierColor,
    Clip? clipBehavior = Clip.hardEdge,
    Color backgroundColor = kBackgroundColor,
  }) async {
    final fullScreenHeight = MediaQuery.of(context).size.height;
    final allowance = MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    // Dynamic modal height computation.
    final maxHeight =
        fullScreen ? fullScreenHeight - allowance : pickerMaxHeight;

    final constraints = BoxConstraints(
      maxHeight: maxHeight,
      minHeight: pickerMinHeight,
      maxWidth: pickerMaxWidth,
    );

    // For automatic scrolling.
    final deviceLocale = ui.PlatformDispatcher.instance.locale.countryCode;

    String? focusedCountry;
    if (scrollToDeviceLocale) {
      if (_codeIsSupported(deviceLocale)) {
        focusedCountry = deviceLocale;
      }
    } else {
      if (_codeIsSupported(initialSelectedLocale)) {
        focusedCountry = initialSelectedLocale;
      }
    }

    final country = showModalBottomSheet<CountryCode?>(
      elevation: 0,
      shape: shape,
      context: context,
      useSafeArea: true,
      constraints: constraints,
      clipBehavior: clipBehavior,
      barrierColor: barrierColor,
      backgroundColor: backgroundColor,
      isScrollControlled: true,
      builder: (_) => CountryCodePickerModal(
        title: title,
        defaultAppbarBackgroundColor: defaultAppbarBackgroundColor,
        defaultAppbarForegroundColor: defaultAppbarForegroundColor,
        defaultAppbarCloseIconBackgroundColor:
            defaultAppbarCloseIconBackgroundColor,
        defaultAppbarText: defaultAppbarText,
        defaultAppbarCloseIcon: defaultAppbarCloseIcon,
        localize: localize,
        favorites: favorites,
        showDialCode: showDialCode,
        favoritesIcon: favoritesIcon,
        horizontalTitleGap: horizontalTitleGap,
        showSearchBar: showSearchBar,
        filteredCountries: filteredCountries,
        searchBarDecoration: searchBarDecoration,
        focusedCountry: focusedCountry,
        countryTextStyle: countryTextStyle,
        dialCodeTextStyle: dialCodeTextStyle,
        searchBarTextStyle: searchBarTextStyle,
      ),
    );

    return country;
  }

  bool _codeIsSupported(String? code) {
    if (code == null) return false;
    final allCountryCodes = codes.map(CountryCode.fromMap).toList();
    final index = allCountryCodes.indexWhere((c) => c.code == code);
    if (index == -1) return false;
    return true;
  }
}
