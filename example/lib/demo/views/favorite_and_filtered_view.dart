import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import '../demo.dart';

class FavoriteAndFilteredPickerView extends StatefulWidget {
  const FavoriteAndFilteredPickerView({Key? key}) : super(key: key);

  @override
  State<FavoriteAndFilteredPickerView> createState() =>
      _FavoriteAndFilteredPickerViewState();
}

class _FavoriteAndFilteredPickerViewState
    extends State<FavoriteAndFilteredPickerView> {
  late final FlCountryCodePicker countryPicker;
  CountryCode? countryCode;

  @override
  void initState() {
    final filteredCountries = ['US', 'PH', 'AU', 'JP', ''];
    final favoriteCountries = ['US', 'PH', 'AU', 'JP'];
    countryPicker = FlCountryCodePicker(
      filteredCountries: filteredCountries,
      favorites: favoriteCountries,
      showSearchBar: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PickerTitle(title: 'Picker with Favorite & Filtered View'),
        TextFormField(
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          maxLines: 1,
          decoration: InputDecoration(
            prefix: GestureDetector(
              onTap: () async {
                final code = await countryPicker.showPicker(
                  context: context,
                );
                if (code != null) {
                  setState(() => countryCode = code);
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Text(countryCode?.dialCode ?? '+1',
                    style: const TextStyle(color: Colors.white)),
              ),
            ),
            labelText: 'Phone',
            fillColor: Colors.white,
            filled: true,
            border: fieldBorder,
          ),
        ),
        const SizedBox(height: 32.0),
        countryCode != null
            ? CountryCodePreview(countryCode: countryCode!)
            : const Text("Tap the TextField's phone number indicator."),
      ],
    );
  }
}
