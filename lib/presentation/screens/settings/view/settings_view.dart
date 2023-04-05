import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/core/base/state/consumer_state_x.dart';
import 'package:recipe_app/core/constants/dimens.dart';
import 'package:recipe_app/core/constants/routes.dart';
import 'package:recipe_app/presentation/tiles/settings_list_tile.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerStateX<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerStateX<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localization.settings,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(Dimens.paddingPageHorizontal, Dimens.paddingPageVertical, Dimens.paddingPageHorizontal,
            Dimens.paddingPageVertical + mediaQuery.padding.bottom),
        children: [
          SettingsListTile(
            icon: Icons.light_mode_rounded,
            text: localization.themeSettings,
            onTap: () => context.pushNamed(Routes.themeSettings),
          ),
          const SizedBox(height: Dimens.paddingTileBetween),
          SettingsListTile(
            icon: Icons.language,
            text: localization.languageSettings,
            onTap: () => context.pushNamed(Routes.languageSettings),
          ),
          const SizedBox(height: Dimens.paddingTileBetween),
          SettingsListTile(
            icon: Icons.info_outline_rounded,
            text: localization.about,
            onTap: () => context.pushNamed(Routes.about),
          ),
        ],
      ),
    );
  }
}
