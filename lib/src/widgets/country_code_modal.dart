import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';

/// {@template country_code_picker_modal}
/// Widget that can be used on showing a modal as bottom sheet that
/// contains all of the [CountryCode]s.
///
/// After pressing the [CountryCode]'s [ListTile], the widget pops
/// and returns the selected [CountryCode] which can be manipulated.
/// {@endtemplate}
class CountryCodePickerModal extends StatefulWidget {
  /// {@macro country_code_picker_modal}
  const CountryCodePickerModal({Key? key}) : super(key: key);

  @override
  State<CountryCodePickerModal> createState() => _CountryCodePickerModalState();
}

class _CountryCodePickerModalState extends State<CountryCodePickerModal> {
  final allCountryCodes = <CountryCode>[];
  final availableCountryCodes = <CountryCode>[];
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    for (final code in codes) {
      allCountryCodes.add(CountryCode.fromMap(code));
    }
    availableCountryCodes.addAll(allCountryCodes);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ModalTitle(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: "'Country', 'Code' or 'Dial Code'",
              hintStyle: TextStyle(fontSize: 12),
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(borderRadius),
                borderSide: BorderSide(
                  width: 2,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              fillColor: Colors.white,
            ),
            onChanged: (query) {
              availableCountryCodes
                ..clear()
                ..addAll(
                  List<CountryCode>.from(
                    allCountryCodes.where(
                      (c) =>
                          c.code.toLowerCase().contains(query.toLowerCase()) ||
                          c.dialCode
                              .toLowerCase()
                              .contains(query.toLowerCase()) ||
                          c.name.toLowerCase().contains(query.toLowerCase()),
                    ),
                  ),
                );
              setState(() {});
            },
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              for (final code in availableCountryCodes)
                ListTile(
                  onTap: () => Navigator.pop(context, code),
                  leading: code.flagImage,
                  title: Text(code.name),
                  trailing: Text(code.dialCode),
                )
            ],
          ),
        ),
      ],
    );
  }
}

class _ModalTitle extends StatelessWidget {
  const _ModalTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'Select your country',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
