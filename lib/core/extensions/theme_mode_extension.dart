import 'package:recipe_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

extension ThemeModeExtension on ThemeMode {
  String toLocalizedString(BuildContext context) {
    final localization = context.localization;
    switch (this) {
      case ThemeMode.dark:
        return localization.dark;
      case ThemeMode.light:
        return localization.light;
      default:
        return localization.system;
    }
  }
}
