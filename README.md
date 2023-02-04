
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

## 🔨 Installation
```yaml
dependencies:
    fl_country_code_picker: ^0.0.4
```
### ⚙ Import
```dart
import  'package:fl_country_code_picker/fl_country_code_picker.dart';
```
## 🕹️ Usage
Instantiate `FlCountryCodePicker` class to access the package's functionalities and properties.
You can also pass some optional parameters to customize the picker's view.
```dart
final countryPicker = const  FlCountryCodePicker();
final countryPickerWithParams = const FlCountryCodePicker(
      favorites: _yourFavorites,
      favoritesIcon: _yourIcon,
      filteredCountries: _yourFilters,
      localize: true,
      searchBarDecoration: _yourInputDecoration,
      showDialCode: true,
      showFavoritesIcon: true,
      showSearchBar: true,
      title: _yourModalTitleWidget,
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
----

### FlCountryCodePicker
**`FlCountryCodePicker`** class contains all of the functionalities of this package. This contains (optional) properties that can be supply to achieve customization at picker's view or appearance.
| Fields | Type| Description |
|:---:|:---:|:---|
| **favorites** | `List<String>?` | Favorite countries that can be shown at the top of the list. Should supply the 2 character ISO code of the country e.g. `['US', 'PH', 'AU']` |
| **favoritesIcon** | `Icon` | Custom icon of favorite countries. Defaults to ❤️. |
| **filteredCountries** | `List<String>?` | Filters all of the [CountryCode]s available and only show the codes that are existing in this list. Should supply the 2 character ISO code of the country e.g. `['US', 'PH', 'AU']` |
| **localize** | `bool` | An optional argument for localizing the country names based on device's current selected Language (country/region). Defaults to `true`. |
| **searchBarDecoration** | `InputDecoration?` | An optional argument for appearance customization of modal's search bar. |
| **showDialCode** | `bool` | An optional argument for showing dial code at country tiles. Defaults to `true`. |
| **showFavoritesIcon** | `bool` | An optional argument for showing favorites icon. Defaults to `true`. |
| **showSearchBar** | `bool` | An optional argument for showing search bar. Defaults to `true`. |
| **showDialCode** | `bool` | An optional argument for showing dial code at country tiles. Defaults to `true`. |
| **title** | `Widget?` | An optional argument for modal's title customization. |
----

### showPicker
**`showPicker`** method under the `FlCountryCodePicker` class that can be used to show the country code picker.
| Fields | Type| Description |
|:---:|:---:|:---|
| **context** | `BuildContext` | A handle to the location of a widget in the widget tree. `Required`.|
| **isFullScreen** | `bool` | Shows the modal in full screen mode. Defaults to `false`. |
| **pickerMinHeight** | `double` | Picker modal constraints for minimum height. Defaults to `150`. |
| **pickerMaxHeight** | `double` | Picker modal constraints for maximum height. Defaults to `500`. |
| **scrollToDeviceLocale** | `bool` | Property to automatically scroll at device's locale within the picker. Defaults to `false`. |
| **initialSelectedLocale** | `String?` | The 2 character ISO code of the country where the scrollController will automatically scroll to. |
----

### CountryCode
**`CountryCode`** model can be used to manipulate the selected country code by the user.
| Fields | Type| Description |
|:---:|:---:|:---|
| **name** | `String` | The name of the country |
| **code** | `String` | The 2 character ISO code of the country|
| **dialCode** | `String` | The country dial code. By convention, international telephone numbers are represented by prefixing the country code with a plus sign (+). e.g. `+1` for *US* |
| **flagImage** | `Widget` | Widget that can be used on retrieving the selected country flag's image. |
| **flagUri** | `String` | Uri of this `CountryCode` located at package's directory to supply at `Image` widget if you're going to get the raw flag image. |
| **flagImagePackage** | `String` | Package to supply at `Image` widget if you're going to get the raw flag image. |
| **localize** | `String` | Convenient getter for localized version of this country code. |
----

### FAQ:
* **How to use country code's flag directory in `Image` widget?**
 ```dart 
		Image.asset(
			 fit: fit,
			 width: width,
			 countryCode.flagUri,
			 alignment: alignment,
			 package: countryCode.flagImagePackage);
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
		);```
```
Then pass it to `FlCountryCodePicker`'s title parameter.
```dart
		countryPicker = const  FlCountryCodePicker(title: title);
```

 * **How to enable package's supported localization?**
  Add the following values at your app's `MaterialApp`
```dart
MaterialApp(
	title: 'Your App',
	supportedLocales: const [
		// Supported locales at the moment.
		// Cannot find your locale? Please make a request.
		Locale('en'),
		Locale('es'),
	],
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
	



## 🐞 Bugs/Requests
If you encounter any problems feel open an issue. If you feel the library is missing a feature, please raise a ticket on Github and we'll look into it. Pull request are also welcome.

## 📃 License
MIT License