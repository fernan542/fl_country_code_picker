import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';

const _previewTextStyle = TextStyle(fontSize: 18.0);

class CountryCodePreview extends StatelessWidget {
  const CountryCodePreview({
    Key? key,
    required this.countryCode,
  }) : super(key: key);

  final CountryCode countryCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Selected Country Name: ${countryCode.name}',
            style: _previewTextStyle),
        const SizedBox(height: 16.0),
        Text('Selected Country Code: ${countryCode.code}',
            style: _previewTextStyle),
        const SizedBox(height: 16.0),
        Text('Selected Country Dial Code: ${countryCode.dialCode}',
            style: _previewTextStyle),
        const SizedBox(height: 16.0),
        Row(
          children: [
            const Text('Selected Country Flag Image:',
                style: _previewTextStyle),
            const SizedBox(width: 16.0),
            countryCode.flagImage,
          ],
        ),
      ],
    );
  }
}
