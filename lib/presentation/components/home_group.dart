import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/dimens.dart';
import 'package:recipe_app/core/extensions/context_extension.dart';

class HomeGroup extends StatelessWidget {
  const HomeGroup({super.key, required this.title, required this.child, this.onMoreTap});

  final String title;
  final Widget child;
  final Function()? onMoreTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localization = context.localization;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.paddingPageHorizontal, Dimens.paddingTileBetween, Dimens.paddingPageHorizontal, 0),
          child: Row(
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium,
                maxLines: 1,
              ),
              const Spacer(),
              if (onMoreTap != null) TextButton(onPressed: onMoreTap, child: Text(localization.showMore))
            ],
          ),
        ),
        child,
      ],
    );
  }
}
