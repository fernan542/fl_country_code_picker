import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import '../demo.dart';

class DefaultPickerView extends StatefulWidget {
  const DefaultPickerView({Key? key}) : super(key: key);

  @override
  State<DefaultPickerView> createState() => _DefaultPickerViewState();
}

class _DefaultPickerViewState extends State<DefaultPickerView> {
  late final FlCountryCodePicker countryPicker;
  late final TextEditingController phoneTextController;
  CountryCode? countryCode;

  bool hasMaxLengthError = false;

  final countryTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    countryCode = CountryCode.fromName('United States');

    phoneTextController = TextEditingController()
      ..addListener(() {
        if (countryCode != null &&
            countryCode!.nationalSignificantNumber != null) {
          if (phoneTextController.text.length !=
              countryCode!.nationalSignificantNumber!) {
            hasMaxLengthError = true;
          } else {
            hasMaxLengthError = false;
          }

          setState(() {});
        }
      });

    countryPicker = const FlCountryCodePicker(
      countryTextStyle: TextStyle(
        color: Colors.red,
        fontSize: 16,
      ),
      dialCodeTextStyle: TextStyle(color: Colors.green, fontSize: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PickerTitle(title: 'Default Picker View'),
        TextFormField(
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          maxLines: 1,
          enabled: false,
          initialValue: 'John Doe',
          decoration: const InputDecoration(
            labelText: 'Name',
            fillColor: Colors.white,
            filled: true,
            border: kFieldBorder,
          ),
        ),
        kSpacer,
        TextFormField(
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          maxLines: 1,
          enabled: false,
          initialValue: 'Marketing Professional',
          decoration: const InputDecoration(
            labelText: 'Job Position',
            fillColor: Colors.white,
            filled: true,
            border: kFieldBorder,
          ),
        ),
        kSpacer,
        TextFormField(
          maxLines: 1,
          controller: phoneTextController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefix: GestureDetector(
              onTap: () async {
                final code = await countryPicker.showPicker(
                  context: context,
                  scrollToDeviceLocale: true,
                  pickerMaxWidth: 600
                );
                if (code != null) {
                  setState(() => countryCode = code);
                  countryTextController.text = code.name;
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
            errorText: hasMaxLengthError
                ? 'Please enter exactly ${countryCode?.nationalSignificantNumber} digits.'
                : null,
          ),
        ),
        kSpacer,
        LayoutBuilder(
          builder: (context, constraints) {
            final fieldWidth = constraints.maxWidth * 0.6;
            final spacerWidth = constraints.maxWidth * 0.1;

            return Row(
              children: [
                SizedBox(
                  width: fieldWidth,
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    enabled: false,
                    controller: countryTextController,
                    decoration: const InputDecoration(
                      labelText: 'Country',
                      fillColor: Colors.white,
                      filled: true,
                      border: kFieldBorder,
                    ),
                  ),
                ),
                SizedBox(width: spacerWidth),
                if (countryCode != null) countryCode!.flagImage()
              ],
            );
          },
        ),
        kSpacer,
        if (countryCode != null) const Text('Custom Image widget: '),
        kSpacer,
        if (countryCode != null)
          Image.asset(
            countryCode!.flagUri,
            width: 100.0,
            fit: BoxFit.cover,
            package: countryCode!.flagImagePackage,
          ),
      ],
    );
  }

  @override
  void dispose() {
    countryTextController.dispose();
    super.dispose();
  }
}
