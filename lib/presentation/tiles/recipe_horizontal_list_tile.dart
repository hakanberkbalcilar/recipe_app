import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/dimens.dart';
import 'package:recipe_app/core/extensions/context_extension.dart';
import 'package:recipe_app/core/extensions/num_extension.dart';
import 'package:recipe_app/domain/entities/recipe.dart';
import 'package:recipe_app/infrastructure/models/recipe_model.dart';

class RecipeHorizontalListTile extends StatelessWidget {
  const RecipeHorizontalListTile(this.recipe, {super.key, this.onTap, this.onFavoriteTap});

  final Recipe recipe;
  final Function()? onTap;
  final Function()? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isFavorite = (recipe as RecipeModel).isInBox;
    return AspectRatio(
      aspectRatio: .75,
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: Dimens.radiusTile.toBorderRadius(),
        color: theme.colorScheme.surface,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      recipe.image,
                      fit: BoxFit.cover,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: onFavoriteTap,
                        icon: Icon(isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded),
                        style: IconButton.styleFrom(
                            backgroundColor: theme.colorScheme.surface, foregroundColor: isFavorite ? theme.colorScheme.primary : null),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.paddingTile),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.label,
                        style: theme.textTheme.titleMedium,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                      const Spacer(),
                      Text(
                        recipe.source,
                        style: theme.textTheme.bodyMedium,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
