import 'package:circle_flags/circle_flags.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:fl_country_code_picker/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

/// {@template country_code_picker_modal}
/// Widget that can be used on showing a modal as bottom sheet that
/// contains all of the [CountryCode]s.
///
/// After pressing the [CountryCode]'s [ListTile], the widget pops
/// and returns the selected [CountryCode] which can be manipulated.
/// {@endtemplate}
class CountryCodePickerModal extends StatefulWidget {
  /// {@macro country_code_picker_modal}
  const CountryCodePickerModal({
    required this.localize,
    required this.favoritesIcon,
    required this.showSearchBar,
    required this.showDialCode,
    this.title,
    this.focusedCountry,
    this.searchBarDecoration,
    this.favorites = const [],
    this.filteredCountries = const [],
    this.countryTextStyle,
    this.dialCodeTextStyle,
    this.horizontalTitleGap,
    this.searchBarTextStyle,
    super.key,
  });

  /// {@macro favorites}
  final List<String> favorites;

  /// {@macro filtered_countries}
  final List<String> filteredCountries;

  /// {@macro favorite_icon}
  final Icon? favoritesIcon;

  /// {@macro show_search_bar}
  final bool showSearchBar;

  /// {@macro show_dial_code}
  final bool showDialCode;

  /// If not null, automatically scrolls the list view to this country.
  final String? focusedCountry;

  /// {@macro title}
  final Widget? title;

  /// {@macro search_bar_decoration}
  final InputDecoration? searchBarDecoration;

  /// {@macro localize}
  final bool localize;

  /// {@macro country_text_style}
  final TextStyle? countryTextStyle;

  /// {@macro dial_code_text_style}
  final TextStyle? dialCodeTextStyle;

  /// {@macro search_bar_text_style}
  final TextStyle? searchBarTextStyle;

  /// space between flag and country name
  final double? horizontalTitleGap;

  @override
  State<CountryCodePickerModal> createState() => _CountryCodePickerModalState();
}

class _CountryCodePickerModalState extends State<CountryCodePickerModal> {
  late final List<CountryCode> baseList;
  final availableCountryCodes = <CountryCode>[];
  late ItemScrollController itemScrollController;

  @override
  void initState() {
    super.initState();
    itemScrollController = ItemScrollController();
    _initCountries();
  }

  Future<void> _initCountries() async {
    final allCountryCodes = codes.map(CountryCode.fromMap).toList();

    final favoriteList = <CountryCode>[
      if (widget.favorites.isNotEmpty)
        ...allCountryCodes.where((c) => widget.favorites.contains(c.code)),
    ];

    final filteredList = [
      ...widget.filteredCountries.isNotEmpty
          ? allCountryCodes.where(
              (c) => widget.filteredCountries.contains(c.code),
            )
          : allCountryCodes,
    ]..removeWhere((c) => widget.favorites.contains(c.code));

    baseList = [...favoriteList, ...filteredList];
    availableCountryCodes.addAll(baseList);

    await Future<void>.delayed(Duration.zero);
    if (!itemScrollController.isAttached) return;

    if (widget.focusedCountry != null) {
      final index = availableCountryCodes.indexWhere(
        (c) => c.code == widget.focusedCountry,
      );

      await itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 600),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title ?? const CcpDefaultModalTitle(),
        if (widget.showSearchBar)
          CcpSearchBar(
            decoration: widget.searchBarDecoration,
            style: widget.searchBarTextStyle,
            onChanged: (query) {
              availableCountryCodes
                ..clear()
                ..addAll(
                  List<CountryCode>.from(
                    baseList.where(
                      (c) {
                        final country =
                            widget.localize ? c.localize(context) : c;

                        return country.code
                                .toLowerCase()
                                .contains(query.toLowerCase()) ||
                            country.dialCode
                                .toLowerCase()
                                .contains(query.toLowerCase()) ||
                            country.name
                                .toLowerCase()
                                .contains(query.toLowerCase());
                      },
                    ),
                  ),
                );
              setState(() {});
            },
          ),
        Expanded(
          child: ScrollablePositionedList.builder(
            itemScrollController: itemScrollController,
            itemCount: availableCountryCodes.length,
            itemBuilder: (context, index) {
              final code = availableCountryCodes[index];
              final name =
                  widget.localize ? code.localize(context).name : code.name;

              final textTheme = Theme.of(context).textTheme;

              return ListTile(
                onTap: () => Navigator.pop(context, code),
                leading: CircleFlag(code.code, size: 40),
                horizontalTitleGap: widget.horizontalTitleGap,
                title: Text(
                  name,
                  style: widget.countryTextStyle ?? textTheme.labelLarge,
                ),
                subtitle: CcpDefaultListItemTrailing(
                  code: code,
                  icon: widget.favoritesIcon,
                  favorites: widget.favorites,
                  showDialCode: widget.showDialCode,
                  dialCodeTextStyle:
                      widget.dialCodeTextStyle ?? textTheme.labelLarge,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
