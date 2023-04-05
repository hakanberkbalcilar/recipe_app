import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/base/state/consumer_state_x.dart';
import 'package:recipe_app/core/constants/dimens.dart';
import 'package:recipe_app/core/enum/languages.dart';
import 'package:recipe_app/di/provider_impl.dart';

class SettingsLanguageView extends ConsumerStatefulWidget {
  const SettingsLanguageView({Key? key}) : super(key: key);

  @override
  ConsumerStateX<SettingsLanguageView> createState() => _SettingsLanguageViewState();
}

class _SettingsLanguageViewState extends ConsumerStateX<SettingsLanguageView> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(localization.themeSettings),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingPageHorizontal, vertical: Dimens.paddingPageVertical),
          itemCount: Languages.values.length,
          separatorBuilder: (context, index) => const SizedBox(height: Dimens.paddingTileBetween),
          itemBuilder: (context, index) {
            final language = Languages.values[index];
            return RadioListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              controlAffinity: ListTileControlAffinity.trailing,
              title: Text(language.toLocalizedString(context)),
              value: language,
              groupValue: settings.language,
              onChanged: settings.changeLanguage,
            );
          },
        ));
  }
}
