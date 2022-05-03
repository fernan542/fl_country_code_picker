// ignore_for_file: prefer_const_constructors
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late FlCountryCodePicker picker;
  late MockBuildContext _mockContext;

  setUp(() {
    _mockContext = MockBuildContext();
    picker = FlCountryCodePicker(context: _mockContext);
  });

  group('FlCountryCodePicker', () {
    test('can be instantiated', () async {
      expect(picker, isNotNull);
    });

    group('countryCodes', () {
      test('gets list of country codes', () {
        expect(
          picker.countryCodes().runtimeType,
          List<CountryCode>,
        );
      });
    });
  });
}
