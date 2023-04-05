import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/dimens.dart';
import 'package:recipe_app/core/extensions/context_extension.dart';
import 'package:recipe_app/core/extensions/num_extension.dart';
import 'package:recipe_app/domain/enums/cuisines.dart';

class CuisineListTile extends StatelessWidget {
  const CuisineListTile(this.cuisine, {super.key, this.onTap});

  final Cuisines cuisine;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: Dimens.radiusTile.toBorderRadius(),
          color: theme.colorScheme.primary.withOpacity(.25),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(cuisine.toLocalizedString(context)),
      ),
    );
  }
}
