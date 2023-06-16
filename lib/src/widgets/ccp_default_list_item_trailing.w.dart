import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';

/// {@template ccp_default_list_item_trailing}
/// The default modal list item trailing if widget is not provided.
/// {@endtemplate}
class CcpDefaultListItemTrailing extends StatelessWidget {
  /// {@macro ccp_default_list_item_trailing}
  const CcpDefaultListItemTrailing({
    Key? key,
    required this.icon,
    required this.code,
    required this.favorites,
    required this.showDialCode,
    required this.showFavoritesIcon,
    this.dialCodeTextStyle,
  }) : super(key: key);

  /// {@macro code}
  final CountryCode code;

  /// {@macro favorites}
  final List<String> favorites;

  /// {@macro favorites_icon}
  final Icon icon;

  /// {@macro show_dial_code}
  final bool showDialCode;

  /// {@macro show_favorites_icon}
  final bool showFavoritesIcon;

  /// {@macro dial_code_text_style}
  final TextStyle? dialCodeTextStyle;

  @override
  Widget build(BuildContext context) {
    if (favorites.isNotEmpty) {
      final index = favorites.indexWhere((f) => f == code.code);
      final iconWidth = MediaQuery.of(context).size.width * 0.2;

      return SizedBox(
        width: iconWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (showDialCode) Text(
                code.dialCode,
              style: dialCodeTextStyle,
            ) else const SizedBox(),
            if (showFavoritesIcon)
              if (index != -1) icon,
          ],
        ),
      );
    } else {
      return showDialCode ? Text(
        code.dialCode,
        style: dialCodeTextStyle,
      ) : const SizedBox();
    }
  }
}
