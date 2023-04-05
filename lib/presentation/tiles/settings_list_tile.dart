import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/dimens.dart';
import 'package:recipe_app/core/extensions/context_extension.dart';
import 'package:recipe_app/core/extensions/num_extension.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({super.key, required this.icon, required this.text, this.showTrailing = true, this.onTap});

  final IconData icon;
  final String text;
  final bool showTrailing;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      leading: Container(
        padding: const EdgeInsets.all(Dimens.paddingSmallX),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: Dimens.radiusLeading.toBorderRadius(),
        ),
        child: Icon(icon),
      ),
      title: Text(
        text,
        style: theme.textTheme.titleMedium,
      ),
      trailing: showTrailing
          ? const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
            )
          : null,
    );
  }
}
