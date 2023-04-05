import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/dimens.dart';
import 'package:recipe_app/core/extensions/context_extension.dart';
import 'package:recipe_app/core/extensions/num_extension.dart';

class VerticalTabView extends StatelessWidget {
  const VerticalTabView({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      decoration: BoxDecoration(color: theme.colorScheme.secondary, borderRadius: Dimens.radiusPage.toTopBorderRadius()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                Dimens.paddingPageHorizontal, Dimens.paddingPageVertical * 1.5, Dimens.paddingPageHorizontal, Dimens.paddingPageVertical * 1.5),
            child: Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onSecondary, fontSize: 20),
            ),
          ),
          Material(
            color: theme.colorScheme.surface,
            clipBehavior: Clip.antiAlias,
            borderRadius: Dimens.radiusPage.toTopBorderRadius(),
            child: child,
          ),
        ],
      ),
    );
  }
}
