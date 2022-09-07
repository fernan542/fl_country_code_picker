import 'package:fl_country_code_picker/fl_country_code_picker.dart';
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
    Key? key,
    this.favorites = const [],
    this.filteredCountries = const [],
    required this.favoritesIcon,
    required this.showSearchBar,
    this.focusedCountry,
  }) : super(key: key);

  /// {@macro favorites}
  final List<String> favorites;

  /// {@macro filtered_countries}
  final List<String> filteredCountries;

  /// {@macro favorite_icon}
  final Icon favoritesIcon;

  /// {@macro show_search_bar}
  final bool showSearchBar;

  /// If not null, automatically scrolls the list view to this country.
  final String? focusedCountry;

  @override
  State<CountryCodePickerModal> createState() => _CountryCodePickerModalState();
}

class _CountryCodePickerModalState extends State<CountryCodePickerModal> {
  late final List<CountryCode> baseList;
  final availableCountryCodes = <CountryCode>[];

  late TextEditingController textController;
  late ItemScrollController itemScrollController;

  @override
  void initState() {
    _initCountries();
    super.initState();
  }

  Future<void> _initCountries() async {
    final allCountryCodes = codes.map(CountryCode.fromMap).toList();
    textController = TextEditingController();
    itemScrollController = ItemScrollController();

    final favoriteList = <CountryCode>[
      if (widget.favorites.isNotEmpty)
        ...allCountryCodes.where((c) => widget.favorites.contains(c.code))
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

    // Temporary fix. Bug when initializing scroll controller.
    // https://github.com/google/flutter.widgets/issues/62
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
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ModalTitle(),
        if (widget.showSearchBar)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
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
              ),
              onChanged: (query) {
                availableCountryCodes
                  ..clear()
                  ..addAll(
                    List<CountryCode>.from(
                      baseList.where(
                        (c) =>
                            c.code
                                .toLowerCase()
                                .contains(query.toLowerCase()) ||
                            c.dialCode
                                .toLowerCase()
                                .contains(query.toLowerCase()) ||
                            c.name.toLowerCase().contains(query.toLowerCase()),
                      ),
                    ),
                  );
                setState(() {});
              },
            ),
          ),
        Expanded(
          child: ScrollablePositionedList.builder(
            itemScrollController: itemScrollController,
            itemCount: availableCountryCodes.length,
            itemBuilder: (context, index) {
              final code = availableCountryCodes[index];

              return ListTile(
                onTap: () => Navigator.pop(context, code),
                leading: code.flagImage,
                title: Text(code.name),
                trailing: _ListTrailing(
                  code: code,
                  favorites: widget.favorites,
                  icon: widget.favoritesIcon,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ListTrailing extends StatelessWidget {
  const _ListTrailing({
    Key? key,
    required this.code,
    required this.favorites,
    required this.icon,
  }) : super(key: key);
  final CountryCode code;
  final List<String> favorites;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) return Text(code.dialCode);

    final index = favorites.indexWhere((f) => f == code.code);
    final iconWidth = MediaQuery.of(context).size.width * 0.2;
    return SizedBox(
      width: iconWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(code.dialCode),
          if (index != -1) icon,
        ],
      ),
    );
  }
}

class _ModalTitle extends StatelessWidget {
  const _ModalTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'Select your country',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
