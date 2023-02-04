import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FakeBuildContext extends Fake implements BuildContext {}

void main() {
  group('CountryCode', () {
    setUpAll(() {
      registerFallbackValue(FakeBuildContext());
    });

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

    group('flagUri', () {
      test('returns the correct flag image uri from asset', () {
        final countryCode = createSubject();
        const directory = 'assets/flags/ph.png';
        expect(
          countryCode.flagUri,
          equals(directory),
        );
      });
    });

    group('flagImagePackage', () {
      testWidgets('can be used at Image widget', (tester) async {
        final countryCode = createSubject();
        final flagUri = countryCode.flagUri;
        final package = countryCode.flagImagePackage;
        final widget = Image.asset(flagUri, package: package);
        await tester.pumpWidget(widget);
        expect(find.byWidget(widget), findsOneWidget);
      });
    });

    group('fromMap', () {
      test('works correctly', () {
        expect(
          CountryCode.fromMap(const <String, dynamic>{
            'name': 'Philippines',
            'code': 'PH',
            'dial_code': '+63',
          }),
          equals(createSubject()),
        );
      });
    });

    group('equality', () {
      test('should return true if instance is the same', () {
        final main = createSubject();
        expect(main == main, true);
      });
      test('should return true if value is the same but instance is different',
          () {
        final main = createSubject();
        final other = createSubject();
        expect(main == other, true);
        expect(main.hashCode == other.hashCode, true);
      });

      test('should return false if values are different', () {
        final main = createSubject().copyWith(name: 'test');
        final other = createSubject();
        expect(main.hashCode == other.hashCode, false);
      });
    });

    group('flagImage', () {
      final countryCode = createSubject();

      testWidgets('shows flag image', (tester) async {
        await tester.pumpWidget(countryCode.flagImage());
        expect(find.byType(Image), findsOneWidget);
      });
    });

    group('copyWith', () {
      test('returns the same object if arguments are not provided', () {
        expect(
          createSubject().copyWith(),
          equals(createSubject()),
        );
      });

      test('replaces every parameter', () {
        expect(
          createSubject().copyWith(
            code: 'test',
            dialCode: 'test',
            name: 'test',
          ),
          equals(
            createSubject(
              code: 'test',
              dialCode: 'test',
              name: 'test',
            ),
          ),
        );
      });
    });

    group('localize', () {
      testWidgets('returns the localized version of country code',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          makeTestableWidget(
            Builder(
              builder: (context) {
                final countryCode = createSubject();

                expect(
                  countryCode.localize(context),
                  equals(createSubject(name: 'Filipinas')),
                );

                return const SizedBox();
              },
            ),
          ),
        );
      });
    });
  });
}

Widget makeTestableWidget(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [
      CountryLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('en'),
      Locale('es'),
    ],
    locale: const Locale('es'),
    home: child,
  );
}
