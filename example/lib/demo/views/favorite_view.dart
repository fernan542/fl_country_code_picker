import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import '../demo.dart';

class FavoritePickerView extends StatefulWidget {
  const FavoritePickerView({Key? key}) : super(key: key);

  @override
  State<FavoritePickerView> createState() => _FavoritePickerViewState();
}

class _FavoritePickerViewState extends State<FavoritePickerView> {
  late final FlCountryCodePicker countryPicker;
  CountryCode? countryCode;

  @override
  void initState() {
    final favoriteCountries = ['US', 'PH', 'AU', 'JP'];
    countryPicker = FlCountryCodePicker(
      favorites: favoriteCountries,
      favoritesIcon: const Icon(Icons.star, color: Colors.yellow),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PickerTitle(title: 'Picker with Favorite View'),
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
            border: kFieldBorder,
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
