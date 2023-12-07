## 0.0.1

Initial release

## 0.0.2

- refactor: make class constable
- refactor: enable access to `CountryCodes` list without using context
- feat: add option for hiding the search bar
- feat: add support for favorite countries ([#1](https://github.com/fernan542/fl_country_code_picker/issues/1))
- feat: add support for countries filtering ([#1](https://github.com/fernan542/fl_country_code_picker/issues/1))

## 0.0.3

- feat: add an automatic scroller if initial country was supplied
- feat: add an option for automatic scrolling at current device's system locale country code

## 0.0.3+1

- chore(dependency): updates version of `scrollable_positioned_list` to 0.3.4

## 0.0.4

- feat: add a flag for showing a country dial code at country tiles ([#4](https://github.com/fernan542/fl_country_code_picker/pull/4))
- docs: update description and instruction at ReadMe

## 0.1.0+3
- docs: ReadMe file improvements
- feat: add support for localization ([#5](https://github.com/fernan542/fl_country_code_picker/issues/5))
- feat: exposed the flagUri for flag image customization ([#5](https://github.com/fernan542/fl_country_code_picker/issues/5))
- feat: add visibility flag for favorite icon ([#5](https://github.com/fernan542/fl_country_code_picker/issues/5))
- refactor: enable customization for modal's title ([#6](https://github.com/fernan542/fl_country_code_picker/issues/6))
- refactor: add Kosovo country ([#5](https://github.com/fernan542/fl_country_code_picker/issues/5))

## 0.1.1
- feat: add more support for internationalization
- refactor: add validator for unsupported device's country/region ([#8](https://github.com/fernan542/fl_country_code_picker/issues/8))

## 0.1.2
- feat: add suuport for localized searching ([#10](https://github.com/fernan542/fl_country_code_picker/issues/10))

## 0.1.3
- fix: uses initState instead of didChangeDependencies for initialization of countries ([#16](https://github.com/fernan542/fl_country_code_picker/issues/16))
- refactor: makes the localization optional to prevent null error
- chore: upgrade dependency to `scrollable_positioned_list v0.3.8`

## 0.1.4
- feat: expose custom country name text style ([#17](https://github.com/fernan542/fl_country_code_picker/pull/17))
- feat: expose custom dial code text style ([#18](https://github.com/fernan542/fl_country_code_picker/pull/18))
- chore: upgrade dependency to `very_good_analysis v4.0.0`

## 0.1.5
- fix: reverts icon width for tile size ([#21](https://github.com/fernan542/fl_country_code_picker/issues/21))
- feat: remove `showFavoritesIcon` and change `favoritesIcon`'s type to nullable

## 0.1.6
- feat: adds optional parameter for horizontal title gap
- refactor: expose custom search bar text style ([#23](https://github.com/fernan542/fl_country_code_picker/pull/23))
- refactor: adds fallback for text styles using the app text theme ([#24](https://github.com/fernan542/fl_country_code_picker/pull/24))

## 0.1.7
- feat: adds support for querying a `CountryCode` using dial code ([#26](https://github.com/fernan542/fl_country_code_picker/pull/26))
- feat: adds support for querying a `CountryCode` using country code ([#26](https://github.com/fernan542/fl_country_code_picker/pull/26))
- feat: adds support for querying a `CountryCode` using country name ([#26](https://github.com/fernan542/fl_country_code_picker/pull/26))
- docs: ReadMe file improvements
- chore: upgrade sdk support to `sdk: ">=3.0.0 <4.0.0"`
- chore: upgrade dependency to `mocktail v1.0.1`

## 0.1.8
- feat: adds support for National Significant Numbers per country
- docs: adds References for data used in project
- fix: removes type of List for country name i18n ([#27](https://github.com/fernan542/fl_country_code_picker/issues/27))
- chore: add i18n support for Burmese (Myanmar) ([#27](https://github.com/fernan542/fl_country_code_picker/issues/27))