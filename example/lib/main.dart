import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'fl_country_code_picker Demo'),
    );
  }
}

const fieldBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(8.0)),
  borderSide: BorderSide(color: Colors.blue, width: 2.0),
);

const previewTextStyle = TextStyle(fontSize: 18.0);

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CountryCode? countryCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              maxLines: 1,
              decoration: InputDecoration(
                prefix: GestureDetector(
                  onTap: () async {
                    final code = await FlCountryCodePicker(
                      context: context,
                      pickerMaxHeight: 500.0,
                    ).showPicker();
                    if (code != null) {
                      setState(() {
                        countryCode = code;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
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
                border: fieldBorder,
              ),
            ),
            const SizedBox(height: 32.0),
            countryCode != null
                ? _CountryCodePreview(countryCode: countryCode!)
                : const Text("Tap the TextField's phone number indicator."),
          ],
        ),
      ),
    );
  }
}

class _CountryCodePreview extends StatelessWidget {
  const _CountryCodePreview({
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
            style: previewTextStyle),
        const SizedBox(height: 16.0),
        Text('Selected Country Code: ${countryCode.code}',
            style: previewTextStyle),
        const SizedBox(height: 16.0),
        Text('Selected Country Dial Code: ${countryCode.dialCode}',
            style: previewTextStyle),
        const SizedBox(height: 16.0),
        Row(
          children: [
            const Text('Selected Country Flag Image:', style: previewTextStyle),
            const SizedBox(width: 16.0),
            countryCode.flagImage,
          ],
        ),
      ],
    );
  }
}
