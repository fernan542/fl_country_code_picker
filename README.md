# fl_country_code_picker

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

A Flutter package for showing a modal that contains country dial code. The user can also search for the available codes and select right from the modal.

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
# Flutter Country Code Picker

Disclaimer, this idea originally came from: [country_code_picker]: https://pub.dev/packages/country_code_picker package.

With this package you can show a country code selector and manipulate the selected `CountryCode` model.

## 🔨 Installation
```yaml
dependencies:
  fl_country_code_picker: ^0.0.1
```

### ⚙ Import

```dart
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
```

## 🕹️ Usage

Just put the component in your application through `VoidCallback` or any functions where you can call the picker.

```dart
  GestureDetector(
    onTap: () async {
      final code = await FlCountryCodePicker(
        context: context,
        pickerMaxHeight: 500.0,
      ).showPicker();
      if (code != null) {
       print(code);
      }
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

## Examples
Mobile `iOS`
<img src="https://raw.githubusercontent.com/Salvatore-Giordano/CountryCodePicker/master/screenshots/screen1.png" width="240"/>
Mobile `android`
<img src="https://raw.githubusercontent.com/Salvatore-Giordano/CountryCodePicker/master/screenshots/screen2.png" width="240"/>

## 🐞 Bugs/Requests

If you encounter any problems feel open an issue. If you feel the library is missing a feature, please raise a ticket on Github and we'll look into it. Pull request are also welcome.

## 📃 License

MIT License