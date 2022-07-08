import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';

/// Modal and TextField borderRadius.
const Radius borderRadius = Radius.circular(10);

/// Show a modal as bottom sheet.
Future<CountryCode?> showModal<CountryCode>({
  required BuildContext context,
  required Icon customIcon,
  double maxHeight = 300,
  double minHeight = 150,
  bool enableDrag = true,
  Color backgroundColor = const Color(0xFFFFFFFF),
  Color barrierColor = const Color(0x50000000),
  bool isFullScreen = false,
  List<String> favorites = const [],
  List<String> filteredCountries = const [],
  bool showSearchBar = false,
}) {
  final fullScreenHeight = MediaQuery.of(context).size.height;
  final allowance = MediaQuery.of(context).padding.top -
      MediaQuery.of(context).padding.bottom;

  return showModalBottomSheet<CountryCode?>(
    context: context,
    isScrollControlled: true,
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: borderRadius,
        topRight: borderRadius,
      ),
    ),
    enableDrag: enableDrag,
    isDismissible: true,
    backgroundColor: backgroundColor,
    barrierColor: barrierColor,
    clipBehavior: Clip.hardEdge,
    constraints: BoxConstraints(
      maxHeight: isFullScreen ? fullScreenHeight - allowance : maxHeight,
      minHeight: minHeight,
    ),
    builder: (_) => CountryCodePickerModal(
      favorites: favorites,
      filteredCountries: filteredCountries,
      customIcon: customIcon,
      showSearchBar: showSearchBar,
    ),
  );
}
