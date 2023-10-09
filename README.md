
# fl_country_code_picker
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link][![License: MIT][license_badge]][license_link]

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis

A Flutter package for showing a modal that contains country dial code. The user can search for the available codes and select right from the modal. Also, it has an [automatic scrolling](https://pub.dev/packages/fl_country_code_picker#showpicker) feature that points at current device's locale. *Supports localizations*!

## 📌 Examples
<img  src="https://github.com/fernan542/fl_country_code_picker/blob/master/screenshots/default-view.gif?raw=true"  width="200"/> <img  src="https://github.com/fernan542/fl_country_code_picker/blob/master/screenshots/picker-with-favorites.gif?raw=true"  width="200"/> <img  src="https://github.com/fernan542/fl_country_code_picker/blob/master/screenshots/picker-with-filter.gif?raw=true"  width="200"/>
<img src="https://github.com/fernan542/fl_country_code_picker/blob/master/screenshots/picker-with-favorite-and-filter.gif?raw=true"  width="200"/>

## 🕹️ Usage
Instantiate `FlCountryCodePicker` class to access the package's functionalities and properties.
You can also pass some optional parameters to customize the picker's view.
```dart
/// Default.
final countryPicker = const  FlCountryCodePicker();

/// With custom params.
final countryPickerWithParams = const FlCountryCodePicker(
      localize: true,
      showDialCode: true,
      showSearchBar: true,
      favoritesIcon: _yourIcon,
      favorites: _yourFavorites,
      title: _yourModalTitleWidget,
      filteredCountries: _yourFilters,
      countryTextStyle: _yourCountryTextStyle,
      dialCodeTextStyle: _yourdialCodeTextStyle,
      searchBarDecoration: _yourInputDecoration,
    );
```
Call the modal for country code picker.
```dart
    GestureDetector(
    onTap: () async {
        // Show the country code picker when tapped.
        final code = await countryPicker.showPicker(context: context);
        // Null check
        if (code != null) print(code);
    },
    child: Container(
        padding: const  EdgeInsets.symmetric(
        horizontal: 8.0, vertical: 4.0),
        margin: const  EdgeInsets.symmetric(horizontal: 8.0),
        decoration: const  BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Text('Show Picker', style: const  TextStyle(color: Colors.white)),
        ),
    ),
```
To enable localization, add the following lines in your `MaterialApp`.
```dart
MaterialApp(
	title: 'Your App',
	// Supported locales at the moment.
	// Cannot find your locale? Please make a request.
	supportedLocales: flc.supportedLocales.map((e) => Locale(e)),
	localizationsDelegates: const [
		// Package's localization delegate.
		CountryLocalizations.delegate,
		GlobalWidgetsLocalizations.delegate,
		GlobalMaterialLocalizations.delegate,
		GlobalCupertinoLocalizations.delegate,
	],
	// ... some omitted values
);
```

----


### ❓ FAQ:
* **How to use country code's flag directory in `Image` widget?**
 ```dart 
Image.asset(
        fit: fit,
        width: width,
        countryCode.flagUri,
        alignment: alignment,
        package: countryCode.flagImagePackage,
);
 ```
 
 * **How to change modal's title?**

First, Create your title `Widget`.
```dart
	const Widget title = Padding(
		padding: EdgeInsets.all(16),
		child: Text(
		'My Title',
		style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
		),
	);
```
Then pass it to `FlCountryCodePicker`'s title parameter.
```dart
countryPicker = const  FlCountryCodePicker(title: title);
```

## 🐞 Bugs/Requests
If you encounter any problems feel open an issue. If you feel the library is missing a feature, please raise a ticket on Github and we'll look into it. Pull request are also welcome.

## 📃 License
MIT License