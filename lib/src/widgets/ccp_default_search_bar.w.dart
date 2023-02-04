import 'package:fl_country_code_picker/src/fl_country_code_picker.dart';
import 'package:flutter/material.dart';

/// Default search bar input decoration.
const _kInputDecoration = InputDecoration(
  hintText: "'Country', 'Code' or 'Dial Code'",
  hintStyle: TextStyle(fontSize: 12),
  suffixIcon: Icon(Icons.search),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(kBorderRadius),
    borderSide: BorderSide(
      width: 2,
      style: BorderStyle.none,
    ),
  ),
  filled: true,
  contentPadding: EdgeInsets.symmetric(horizontal: 16),
  fillColor: Colors.white,
);

/// {@template ccp_default_search_bar}
/// The default modal search bar widget that can be customized by supplying
/// the [decoration] parameter.
/// {@endtemplate}
class CcpDefaultSearchBar extends StatelessWidget {
  /// {@macro ccp_default_search_bar}
  const CcpDefaultSearchBar({
    Key? key,
    this.onChanged,
    this.decoration,
  }) : super(key: key);

  /// Callback function on query changed.
  final void Function(String)? onChanged;

  /// {@macro search_bar_decoration}
  final InputDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onChanged: onChanged,
        decoration: decoration ?? _kInputDecoration,
        keyboardType: TextInputType.text,
      ),
    );
  }
}
