

# fl_country_code_picker

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link][![License: MIT][license_badge]][license_link]

A Flutter package for showing a modal that contains country dial code. The user can search for the available codes and select right from the modal. This also has an [automatic scrolling](https://pub.dev/packages/fl_country_code_picker#showpicker) feature that points at current device's locale.

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis

## 🔨 Installation
```yaml
dependencies:
  fl_country_code_picker: ^0.0.4
```

### ⚙ Import

```dart
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
```

## 🕹️ Usage

Instantiate `FlCountryCodePicker` to access the functionality and properties. 
You can also pass some optional parameters to customize the picker's view.
```dart
final countryPicker = const FlCountryCodePicker();
```
```dart
  GestureDetector(
    onTap: () async {
        final code = await countryPicker.showPicker(context: context);
        if (code != null)  print(code);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0, vertical: 4.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Text('Show Picker',
          style: const TextStyle(color: Colors.white)),
    ),
  ),
```
### FlCountryCodePicker
 **`FlCountryCodePicker`** class contains all of the functionalities of this package. This contains (optional) properties that can be supply to achieve some customization at the picker's view.

| Fields | Type| Description |
|:---:|:---:|:---|
| **favorites** | List<String> |  Favorite countries that can be shown at the top of the list. Should supply the 2 character ISO code of the country e.g. `['US', 'PH', 'AU']` |
| **filteredCountries** | List<String> | Filters all of the [CountryCode]s available and only show the codes that are existing in this list. Should supply the 2 character ISO code of the country e.g. `['US', 'PH', 'AU']` |
| **favoritesIcon** | Icon | Custom icon of favorite countries. Defaults to `Icons.favorite` |
| **showSearchBar** | bool | An optional argument for showing search bar. Defaults to `true`. |
| **showDialCode** | bool | An optional argument for showing dial code at country tiles. Defaults to `true`. |

### showPicker
 **`showPicker`** method under FlCountryCodePicker class can be used to show a country code picker.

| Fields | Type| Description |
|:---:|:---:|:---|
| **context** | **BuildContext** | A handle to the location of a widget in the widget tree. `Required`.|
| **isFullScreen** | bool | Shows the modal in full screen mode. Defaults to `false`. |
| **pickerMinHeight** | double | Picker modal constraints for minimum height. Defaults to `150`. |
| **pickerMaxHeight** | double | Picker modal constraints for maximum height. Defaults to `500`. |
| **scrollToDeviceLocale** | bool | Property to automatically scroll at device's locale within the picker. Defaults to `false`. |
| **initialSelectedLocale** | String? | The 2 character ISO code of the country where the scrollController will automatically scroll to. |

### CountryCode
 **`CountryCode`** model can be used to manipulate the selected country code by the user.

| Fields | Type| Description |
|:---:|:---:|:---|
| **name** | String | The name of the country |
| **code** | String | The 2 character ISO code of the country|
| **dialCode** | String | The country dial code. By convention, international telephone numbers are represented by prefixing the country code with a plus sign (+). e.g. `+1` for *US* |
| **flagImage** | Widget| Widget that can be used on retrieving the selected country flag's image. |




## Examples
| Example View | Preview (from package's example folder) |
| :---: | :---: |
| Default Picker View |<img src="https://github.com/fernan542/fl_country_code_picker/blob/master/screenshots/default-view.gif?raw=true" width="200"/>|
| Picker with Favorites |<img src="https://github.com/fernan542/fl_country_code_picker/blob/master/screenshots/picker-with-favorites.gif?raw=true" width="200"/>|
| Picker with Filter |<img src="https://github.com/fernan542/fl_country_code_picker/blob/master/screenshots/picker-with-filter.gif?raw=true" width="200"/>|
| Picker with Favorite and Filter |<img src="https://github.com/fernan542/fl_country_code_picker/blob/master/screenshots/picker-with-favorite-and-filter.gif?raw=true" width="200"/>|


## 🐞 Bugs/Requests

If you encounter any problems feel open an issue. If you feel the library is missing a feature, please raise a ticket on Github and we'll look into it. Pull request are also welcome.

## 📃 License

MIT License