// ignore_for_file: public_member_api_docs

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
    this.defaultAppbarBackgroundColor = const Color(0xffEDF2F4),
    this.defaultAppbarForegroundColor = Colors.black,
    this.defaultAppbarCloseIconBackgroundColor =
        const Color.fromARGB(255, 224, 224, 224),
    this.defaultAppbarText = 'Select Country Code',
    this.defaultAppBarTextStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 19,
    ),
    this.isShowFlag = false,

    this.defaultAppbarCloseIcon = Icons.clear_rounded,
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

  /// {@macro default_appbar_background_color}
  final Color defaultAppbarBackgroundColor;

  /// {@macro default_appbar_foreground_color}
  final Color defaultAppbarForegroundColor;

  /// {@macro default_appbar_close_icon_background_color}
  final Color defaultAppbarCloseIconBackgroundColor;

  /// {@macro default_appbar_text}
  final String defaultAppbarText;
  /// {@macro default_appbar_text_style}
  final TextStyle defaultAppBarTextStyle;

  /// {@macro default_appbar_close_icon}
  final IconData defaultAppbarCloseIcon;

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

  /// show flag
  final bool isShowFlag;

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
    return Scaffold(
      backgroundColor: const Color(0xffEDF2F4),
      body: CustomScrollView(
        slivers: [
          if (widget.title != null)
            SliverPersistentHeader(
              delegate: _StickyTitleDelegate(
                height: kToolbarHeight,
                title: widget.title!,
              ),
              pinned: true,
            )
          else
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: widget.defaultAppbarBackgroundColor,
              foregroundColor: widget.defaultAppbarForegroundColor,
              // surfaceTintColor: Colors.transparent,
              expandedHeight: 114,
              pinned: true,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final top = constraints.biggest.height;
                  var paddingStart = 82 -
                      (82 - 16) *
                          (top - kToolbarHeight) /
                          (114 - kToolbarHeight);
                  paddingStart = paddingStart.clamp(16.0, 82.0);
                  // if (kDebugMode) {
                  //   print('$top - $kToolbarHeight - $paddingStart');
                  // }

                  return FlexibleSpaceBar(
                    centerTitle: false,
                    titlePadding: EdgeInsetsDirectional.only(
                      start: paddingStart,
                      bottom: 15,
                    ),
                    expandedTitleScale: 1.49,
                    title: Text(
                      widget.defaultAppbarText,
                      style: widget.defaultAppBarTextStyle,
                    ),
                  );
                },
              ),
            ),
          if (widget.showSearchBar)
            SliverPersistentHeader(
              delegate: _StickySearchBarDelegate(
                searchBar: ColoredBox(
                  color: widget.defaultAppbarBackgroundColor,
                  child: CcpSearchBar(
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
                ),
                height: 60,
              ),
              pinned: true,
            ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final code = availableCountryCodes[index];
                final name =
                    widget.localize ? code.localize(context).name : code.name;

                final textTheme = Theme.of(context).textTheme;

                return widget.isShowFlag ? ListTile(
                  onTap: () => Navigator.pop(context, code),
                  leading:  CircleFlag(code.code, size: 40),
                  horizontalTitleGap: widget.horizontalTitleGap,
                  title: Text(
                    name,
                    style: widget.countryTextStyle ?? textTheme.labelLarge,
                  ),
                  trailing: CcpDefaultListItemTrailing(
                    code: code,
                    icon: widget.favoritesIcon,
                    favorites: widget.favorites,
                    showDialCode: widget.showDialCode,
                    dialCodeTextStyle:
                        widget.dialCodeTextStyle ?? textTheme.labelLarge,
                  ),
                ) : ListTile(
                  onTap: () => Navigator.pop(context, code),
                  horizontalTitleGap: widget.horizontalTitleGap,
                  title: Text(
                    name,
                    style: widget.countryTextStyle ?? textTheme.labelLarge,
                  ),
                  trailing: CcpDefaultListItemTrailing(
                    code: code,
                    icon: widget.favoritesIcon,
                    favorites: widget.favorites,
                    showDialCode: widget.showDialCode,
                    dialCodeTextStyle:
                        widget.dialCodeTextStyle ?? textTheme.labelLarge,
                  ),
                );
              },
              childCount: availableCountryCodes.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _StickySearchBarDelegate extends SliverPersistentHeaderDelegate {
  _StickySearchBarDelegate({required this.searchBar, required this.height});
  final Widget searchBar;
  final double height;

  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: searchBar);
  }

  @override
  bool shouldRebuild(_StickySearchBarDelegate oldDelegate) {
    return searchBar != oldDelegate.searchBar || height != oldDelegate.height;
  }
}

class _StickyTitleDelegate extends SliverPersistentHeaderDelegate {
  _StickyTitleDelegate({required this.title, required this.height});
  final Widget title;
  final double height;

  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: title);
  }

  @override
  bool shouldRebuild(_StickyTitleDelegate oldDelegate) {
    return title != oldDelegate.title || height != oldDelegate.height;
  }
}
