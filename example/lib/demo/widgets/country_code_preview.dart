import 'package:example/demo/demo.dart';
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
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Selected Country Name: ${countryCode.name}',
                style: _previewTextStyle),
            kSpacer,
            Text('Selected Country Code: ${countryCode.code}',
                style: _previewTextStyle),
            kSpacer,
            Text('Selected Country Dial Code: ${countryCode.dialCode}',
                style: _previewTextStyle),
            kSpacer,
            Row(
              children: [
                const Text('Selected Country Flag Image:',
                    style: _previewTextStyle),
                const SizedBox(width: 16.0),
                countryCode.flagImage(),
              ],
            ),
            kSpacer,
            Image.asset(
              countryCode.flagUri,
              width: 100.0,
              fit: BoxFit.cover,
              package: countryCode.flagImagePackage,
            ),
          ],
        );
      },
    );
  }
}
