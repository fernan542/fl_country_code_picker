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
    this.localize = true,
    this.searchBarDecoration,
    this.showDialCode = true,
    this.showSearchBar = true,
    this.favorites = const [],
    this.filteredCountries = const [],
    this.favoritesIcon,
    this.countryTextStyle,
    this.searchBarStyle,
    this.dialCodeTextStyle,
    @Deprecated(
      'This property will be removed because it is '
      'unnecessary after making the [favoritesIcon] nullable. '
      'If you want to show favorites icon, just supply the '
      'value for [favoritesIcon].',
    )
    this.showFavoritesIcon = false,
  });

  /// Convinience getter for all of the available country codes.
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

  /// {@template favorites_icon}
  /// Custom icon of favorite countries.
  ///
  /// <i class="material-icons md-36">favorite</i> &#x2014;  Defaults to `Icons.favorite`
  /// {@endtemplate}
  final Icon? favoritesIcon;

  /// {@template show_favorites_icon}
  /// An optional argument for showing favorites icon.
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  @Deprecated(
    'This property will be removed because it is '
    'unnecessary after making the [favoritesIcon] nullable. '
    'If you want to show favorites icon, just supply the '
    'value for [favoritesIcon].',
  )
  final bool showFavoritesIcon;

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

  /// {@template item_builder}
  ///
  /// {@endtemplate}
  // final IndexedWidgetBuilder itemBuilder;

  /// {@template title}
  /// Can be used to customize the title for country code picker modal.
  /// {@endtemplate}
  final Widget? title;

  /// {@template search_bar_decoration}
  /// Can be used to customize the appearance of search bar.
  /// {@endtemplate}
  final InputDecoration? searchBarDecoration;

  /// {@template search_bar_style}
  /// Can be used to customize the Style of search bar.
  /// {@endtemplate}
  final TextStyle? searchBarStyle;

  /// {@template localize}
  /// An optional argument for localizing the country names based on
  /// device's current selected Language (country/region).
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool localize;

  /// {@template country_text_style}
  /// Can be used to customize the style of the country name.
  /// {@endtemplate}
  final TextStyle? countryTextStyle;

  /// {@template dial_code_text_style}
  /// Can be used to customize the appearance of the phone code eg: +1
  /// {@endtemplate}
  final TextStyle? dialCodeTextStyle;

  /// Shows the [CountryCodePickerModal] modal.
  ///
  /// Parameters:
  /// * context - A handle to the location of a widget in the widget tree.
  /// * isFullScreen - Shows the modal in full screen mode.
  /// * pickerMinHeight / pickerMaxHeight - Picker modal constraints.
  /// * scrollToDeviceLocale - Automatically scroll to device's locale.
  /// * initialSelectedLocale - Automatically scroll to user-defined locale.
  ///
  /// If `scrollToDeviceLocale` was set to `true`, it will override the
  /// value from `initialSelectedLocale` parameter.
  ///
  /// Returns the selected [CountryCode] by the user.
  Future<CountryCode?> showPicker({
    required BuildContext context,
    bool fullScreen = false,
    ShapeBorder shape = kShape,
    double pickerMinHeight = 150,
    double pickerMaxHeight = 500,
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
    );

    // For automatic scrolling.
    final deviceLocale = WidgetsBinding.instance.window.locale.countryCode;

    final focusedCountry = scrollToDeviceLocale
        ? _validateIfCountryCodeIsSupported(deviceLocale)
            ? deviceLocale
            : null
        : _validateIfCountryCodeIsSupported(initialSelectedLocale)
            ? initialSelectedLocale
            : null;

    final country = showModalBottomSheet<CountryCode?>(
      elevation: 0,
      shape: shape,
      context: context,
      constraints: constraints,
      clipBehavior: clipBehavior,
      barrierColor: barrierColor,
      backgroundColor: backgroundColor,
      isScrollControlled: true,
      builder: (_) => CountryCodePickerModal(
        title: title,
        localize: localize,
        favorites: favorites,
        showDialCode: showDialCode,
        favoritesIcon: favoritesIcon,
        showSearchBar: showSearchBar,
        filteredCountries: filteredCountries,
        searchBarDecoration: searchBarDecoration,
        focusedCountry: focusedCountry,
        countryTextStyle: countryTextStyle,
        dialCodeTextStyle: dialCodeTextStyle,
        searchBarStyle: searchBarStyle,
      ),
    );

    return country;
  }

  bool _validateIfCountryCodeIsSupported(String? code) {
    if (code == null) return false;
    final allCountryCodes = codes.map(CountryCode.fromMap).toList();
    final index = allCountryCodes.indexWhere((c) => c.code == code);
    if (index == -1) return false;
    return true;
  }
}
