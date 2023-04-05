import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/dimens.dart';
import 'package:recipe_app/core/extensions/context_extension.dart';
import 'package:recipe_app/domain/entities/recipe.dart';
import 'package:recipe_app/infrastructure/models/recipe_model.dart';
import 'package:recipe_app/presentation/components/tile_leading_image.dart';

class RecipeListTile extends StatelessWidget {
  const RecipeListTile(this.recipe, {super.key, this.onTap, this.onFavoriteTap});

  final Recipe recipe;
  final Function()? onTap;
  final Function()? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isFavorite = (recipe as RecipeModel).isInBox;
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: Dimens.paddingTile, vertical: 2),
      leading: TileLeadingImage(recipe.image),
      title: Text(
        recipe.label,
        maxLines: 1,
      ),
      subtitle: Text(
        recipe.source,
        maxLines: 1,
      ),
      trailing: IconButton(
        onPressed: onFavoriteTap,
        icon: Icon(isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded),
        style: IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap, foregroundColor: isFavorite ? theme.colorScheme.primary : null),
      ),
    );
  }
}
