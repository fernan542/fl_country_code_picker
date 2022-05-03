
# fl_country_code_picker

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link][![License: MIT][license_badge]][license_link]

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

Just put the component in your application through any functions where you can show the picker.

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
 `CountryCode` object can be used to manipulate the selected country code by the user.
| | Type| Description |
|------------|-----------:|------:|
| **name** | String | The name of the country |
| **code** | String| The 2 character ISO code of the country|
| **dialCode** | String | The country dial code. By convention, international telephone numbers are represented by prefixing the country code with a plus sign (+). e.g. `+1` for *U*S |
| **flagImage** | Widget| Widget that can be used on retrieving the selected country flag's image. |


## Examples
Mobile and Web preview
<div style="text-align: center">
    <table>
        <tr>
            <td style="text-align: center">
            <img src="https://github.com/fernan542/fl_country_code_picker/blob/master/screenshots/fl_gif_1.gif?raw=true" width="200"/>
            </td>            
            <td style="text-align: center">
            <img src="https://github.com/fernan542/fl_country_code_picker/blob/master/screenshots/fl_gif_2.gif?raw=true" width="200"/>
            </td>
        </tr>
    </table>
</div>

## 🐞 Bugs/Requests

If you encounter any problems feel open an issue. If you feel the library is missing a feature, please raise a ticket on Github and we'll look into it. Pull request are also welcome.

## 📃 License

MIT License