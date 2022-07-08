import 'package:flutter/material.dart';

import '../demo.dart';

const fieldBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(8.0)),
  borderSide: BorderSide(color: Colors.blue, width: 2.0),
);

class DemoPage extends StatelessWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Demo',
          style: TextStyle(
            color: Colors.black,
            fontSize: 40.0,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: PageView.builder(
          itemCount: 4,
          pageSnapping: true,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Builder(
                  builder: (context) {
                    if (index == 0) return const DefaultPickerView();
                    if (index == 1) return const FavoritePickerView();
                    if (index == 2) return const FilteredPickerView();
                    if (index == 3) {
                      return const FavoriteAndFilteredPickerView();
                    }
                    return Container();
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
