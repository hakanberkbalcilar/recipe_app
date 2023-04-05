import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/dimens.dart';
import 'package:recipe_app/core/extensions/context_extension.dart';
import 'package:recipe_app/core/extensions/num_extension.dart';
import 'package:recipe_app/domain/entities/recipe_ingredient.dart';

class IngredientListTile extends StatelessWidget {
  const IngredientListTile(this.ingredient, {super.key});

  final RecipeIngredient ingredient;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: Dimens.paddingTile, vertical: 0),
      leading: AspectRatio(
        aspectRatio: 1,
        child: Container(
            decoration: BoxDecoration(borderRadius: Dimens.radiusTile.toBorderRadius(), color: theme.colorScheme.background),
            child: const Icon(Icons.soup_kitchen_rounded)),
      ),
      title: Text(ingredient.food),
      subtitle: Text(
        ingredient.weight.toFixedString(sign: ' g'),
        style: theme.textTheme.labelLarge,
      ),
      trailing: Text(
        '${ingredient.quantity.toFixedString()} ${ingredient.measure}',
        style: theme.textTheme.labelLarge,
      ),
    );
  }
}
