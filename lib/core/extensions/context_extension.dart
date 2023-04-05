import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  AppLocalizations get localization => AppLocalizations.of(this)!;
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  bool get isMobile => MediaQuery.of(this).size.width < 650;

  bool get isTablet => MediaQuery.of(this).size.width >= 650;

  bool get isDesktop => MediaQuery.of(this).size.width >= 1200;

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(String content, {Duration? duration}) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(content), duration: duration ?? const Duration(seconds: 1)));

  bool get mounted {
    try {
      (this as Element).widget;
      return true;
    } on TypeError catch (_) {
      return false;
    }
  }
}
