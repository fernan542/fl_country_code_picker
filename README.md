
# fl_country_code_picker
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link][![License: MIT][license_badge]][license_link]

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis

A Flutter package for showing a modal that contains country dial code. The user can search for the available codes and select right from the modal. Also, it has an [automatic scrolling](https://pub.dev/packages/fl_country_code_picker#showpicker) feature that points at current device's locale. *Supports localizations*!

Where do the data come from? Check the [references](https://pub.dev/packages/fl_country_code_picker#References) for more information about the data.

## 📌 Examples
<img  src="https://media.giphy.com/media/Kp6uZ5WxIxtaCTdNkN/giphy.gif"  width="200"/> <img  src="https://media.giphy.com/media/09n1sHf2oFLzBpWctD/giphy.gif"  width="200"/> <img  src="https://media.giphy.com/media/gfkiH5sD3pssUTtTxN/giphy.gif"  width="200"/>
<img src="https://media.giphy.com/media/4SakLnCdChJGVQWjLf/giphy.gif"  width="200"/>

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
        final picked= await countryPicker.showPicker(context: context);
        // Null check
        if (picked!= null) print(picked);
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
import  'package:fl_country_code_picker/fl_country_code_picker.dart' as flc;
```
```dart
MaterialApp(
	title: 'Your App',
	// Supported locales at the moment.
	// Cannot find your locale? Please make a request.
	supportedLocales: flc.supportedLocales.map((e) => Locale(e)),
	localizationsDelegates: const [
	    // Package's localization delegate.
            // You can still add other delegates from your app.
		CountryLocalizations.delegate,
	],
	// ... some omitted values
);
```

----
## 🆕 What's New?
- Added `i18n` support for **Burmese (Myanmar)**
- Improved documentation by adding data references.
- Added support for National Significant Numbers (NSN) per country.
  - Check the example for default view to use NSN.

  <img  src="https://media.giphy.com/media/sgYviJWb2ktMvL0sPy/giphy.gif"  width="200"/>

----

### FlCountryCodePicker
**`FlCountryCodePicker`** class contains all of the functionalities of this package. This contains (optional) properties that can be supply to achieve customization at picker's view or appearance.

|Fields|Type| Description                                                                                                                                                                         |
|:---:|:---:|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **title** | `Widget?` | An optional argument for modal's title customization.
| **localize** | `bool` | An optional argument for localizing the country names based on device's current selected Language (country/region). Make sure to add the required delegates to your `MaterialApp`. Defaults to `true`.
| **horizontalTitleGap** | `double?` | An optional argument for horizontal space between flag, country name, and trailing icon.
| **searchBarDecoration** | `InputDecoration?` | An optional argument for appearance customization of modal's search bar.                                                                                                            
| **showDialCode** | `bool` | An optional argument for showing dial code at each tile. Defaults to `true`.
| **showSearchBar** | `bool` | An optional argument for showing search bar. Defaults to `true`.                                                                                                 
| **favorites** | `List<String>?` | Favorite countries that can be shown at the top of the list. Should supply the 2 character ISO code of the country e.g. `['US', 'PH', 'AU']`                                        |
| **filteredCountries** | `List<String>?` | Filters all of the [CountryCode]s available and only show the codes that are existing in this list. Should supply the 2 character ISO code of the country e.g. `['US', 'PH', 'AU']`
| **favoritesIcon** | `Icon` | Custom icon of favorite countries. Defaults to ❤️.                                                                                                                                  
| **countryTextStyle** | `TextStyle?` | An optional argument for country name text customization.                                              
| **dialCodeTextStyle** | `TextStyle?` | An optional argument for phone code text customization.                                                                                                               
| **searchBarTextStyle** | `TextStyle?` | An optional argument for search bar text customization.
----

### showPicker
**`showPicker`** is a method under the `FlCountryCodePicker` that can be used to show and customize the country code picker modal.

|Fields|Type|Description|
|:---:|:---:|:---|
| **context** | `BuildContext` | A handle to the location of a widget in the widget tree. `Required`.|
| **isFullScreen** | `bool` | Shows the modal in full screen mode. Defaults to `false`. |
| **shape** | `ShapeBorder` | The shape of the modal. Defaults to `RoundedRectangleBorder` with rounded top corners. |
| **pickerMinHeight** | `double` | Picker modal constraints for minimum height. Defaults to `150`. |
| **pickerMaxHeight** | `double` | Picker modal constraints for maximum height. Defaults to `500`. |
| **scrollToDeviceLocale** | `bool` | Property to automatically scroll at device's locale within the picker. Defaults to `false`. |
| **initialSelectedLocale** | `String?` | The 2 character ISO code of the country where the scrollController will automatically scroll to. |
| **barrierColor** | `Color` | Color of the modal barrier. Defaults to black with low opacity. |
| **clipBehavior** | `Clip?` | Can be passed in to customize the appearance of modal. Defaults to `Clip.hardEdge`. |
| **backgroundColor** | `Color?` | Can be passed in to customize the appearance of modal. Defaults to white. |


----

### CountryCode
**`CountryCode`** model can be used to manipulate the selected country code by the user.

|Fields|Parameter|Returns|Description|
|:---:|:---:|:---:|:---|
| **name** | `n/a` | `String` | The name of the country |
| **code** | `n/a` | `String` | The 2 character ISO code of the country|
| **dialCode** | `n/a` | `String` | The country dial code. By convention, international telephone numbers are represented by prefixing the country code with a plus sign (+). e.g. `+1` for *US* |
| **nationalSignificantNumber** | `n/a` | `int?` | The number of digits that allow to uniquely identify a number within the country. It excludes the country code and any trunk code or access code. It includes the mobile prefix towards the total number of digits. </br> Returns `null` if country doesn't have concrete value for NSN.|
| **flagImage** | `n/a` | `Widget` | Widget that can be used on retrieving the selected country flag's image. |
| **flagUri** | `n/a` | `String` | Uri of this `CountryCode` located at package's directory to supply at `Image` widget if you're going to get the raw flag image. |
| **flagImagePackage** | `n/a` | `String` | Package to supply at `Image` widget if you're going to get the raw flag image. |
| **localize** | `n/a` | `String` | Convenient getter for localized version of this country code. |
| **fromDialCode** | `String?` | `CountryCode` | Static method that gets `CountryCode` based on the given *dial code*. Returns `null` if not found. e.g. `CountryCode.fromDialCode('+63')` |
| **fromCode** | `String?` | `CountryCode` | Static method that gets `CountryCode` based on the given *country code*. Returns `null` if not found. e.g. `CountryCode.fromCode('PH')` |
| **fromName** | `String?` | `CountryCode` | Static method that gets `CountryCode` based on the given *country name*. Returns `null` if not found. e.g. `CountryCode.fromName('Philippines')` |
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

## 📚 References
* Internationalization Codes: https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
* Country Codes: https://countrycode.org
* International Call Prefixes: https://www.globalcallforwarding.com/international-call-prefixes
* National Significant Number https://en.wikipedia.org/wiki/List_of_mobile_telephone_prefixes_by_country

## 🐞 Bugs/Requests
If you encounter any problems feel open an issue. If you feel the library is missing a feature, please raise a ticket on Github and we'll look into it. Pull request are also welcome.

## 📃 License
MIT License