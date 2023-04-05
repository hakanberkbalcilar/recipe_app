import 'package:recipe_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

enum Languages {
  system(null, null),
  english('en', 'US'),
  turkish('tr', 'TR');

  const Languages(this.languageCode, this.countryCode);

  final String? languageCode;
  final String? countryCode;

  Locale? get locale => languageCode == null ? null : Locale(languageCode!, countryCode);
  String? get localeName => languageCode == null ? null : '$languageCode-$countryCode';

  String toLocalizedString(BuildContext context) {
    final localization = context.localization;

    switch (this) {
      case Languages.english:
        return localization.english;
      case Languages.turkish:
        return localization.turkish;
      default:
        return localization.system;
    }
  }
}
