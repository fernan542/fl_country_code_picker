// ignore_for_file: prefer_const_constructors
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FlCountryCodePicker picker;

  setUp(() {
    picker = FlCountryCodePicker();
  });

  group('FlCountryCodePicker', () {
    test('can be instantiated', () async {
      expect(picker, isNotNull);
    });

    group('countryCodes', () {
      test('gets list of country codes', () {
        expect(
          picker.countryCodes.runtimeType,
          <CountryCode>[],
        );
      });
    });
  });
}
