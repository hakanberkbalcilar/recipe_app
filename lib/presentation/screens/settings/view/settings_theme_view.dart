import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/base/state/consumer_state_x.dart';
import 'package:recipe_app/core/constants/dimens.dart';
import 'package:recipe_app/core/extensions/theme_mode_extension.dart';
import 'package:recipe_app/di/provider_impl.dart';

class SettingsThemeView extends ConsumerStatefulWidget {
  const SettingsThemeView({Key? key}) : super(key: key);

  @override
  ConsumerStateX<SettingsThemeView> createState() => _SettingsThemeViewState();
}

class _SettingsThemeViewState extends ConsumerStateX<SettingsThemeView> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(localization.themeSettings),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingPageHorizontal, vertical: Dimens.paddingPageVertical),
          itemCount: ThemeMode.values.length,
          separatorBuilder: (context, index) => const SizedBox(height: Dimens.paddingTileBetween),
          itemBuilder: (context, index) {
            final themeMode = ThemeMode.values[index];
            return RadioListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text(themeMode.toLocalizedString(context)),
                value: themeMode,
                groupValue: settings.themeMode,
                onChanged: settings.changeThemeMode);
          },
        ));
  }
}
