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
  CountryCode? countryCode;

  final countryTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    countryPicker = const FlCountryCodePicker(
      countryTextStyle: TextStyle(
        color: Colors.red,
        fontSize: 16,
      )
    );
  }

  @override
  void dispose() {
    countryTextController.dispose();
    super.dispose();
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
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          maxLines: 1,
          decoration: InputDecoration(
            prefix: GestureDetector(
              onTap: () async {
                final code = await countryPicker.showPicker(
                  context: context,
                  scrollToDeviceLocale: true,
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
          ),
        ),
        kSpacer,
        Builder(builder: (context) {
          final _fieldWidth = MediaQuery.of(context).size.width * 0.6;
          final _spacerWidth = MediaQuery.of(context).size.width * 0.1;

          return Row(
            children: [
              SizedBox(
                width: _fieldWidth,
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
              SizedBox(width: _spacerWidth),
              if (countryCode != null) countryCode!.flagImage()
            ],
          );
        }),
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
}
