// ignore: lines_longer_than_80_chars
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CountryCode', () {
    CountryCode createSubject({
      String code = 'PH',
      String dialCode = '+63',
      String name = 'Philippines',
    }) {
      return CountryCode(
        code: code,
        dialCode: dialCode,
        name: name,
      );
    }

    group('constructor', () {
      test('works correctly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });
    });

    group('fromMap', () {
      test('works correctly', () {
        expect(
          CountryCode.fromMap(<String, dynamic>{
            'name': 'Philippines',
            'code': 'PH',
            'dial_code': '+63',
          }),
          equals(createSubject()),
        );
      });
    });

    group('flagImage', () {
      final selectedCountry = createSubject();

      testWidgets('shows flag image', (tester) async {
        await tester.pumpWidget(selectedCountry.flagImage);

        expect(find.byType(Image), findsOneWidget);
      });
    });
  });
}
