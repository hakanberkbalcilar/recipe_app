import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/dimens.dart';
import 'package:recipe_app/core/extensions/context_extension.dart';
import 'package:recipe_app/core/extensions/num_extension.dart';
import 'package:recipe_app/domain/entities/recipe.dart';
import 'package:recipe_app/presentation/components/tile_leading_image.dart';

class FavoriteListTile extends StatelessWidget {
  const FavoriteListTile(this.recipe, {super.key, this.onTap, this.onDeleteTap});

  final Recipe recipe;
  final Function()? onTap;
  final Function()? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localization = context.localization;
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(color: Colors.red, borderRadius: Dimens.radiusTile.toBorderRadius()),
        padding: const EdgeInsets.all(Dimens.paddingTile),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.delete_forever_rounded,
              color: theme.colorScheme.onPrimary,
            ),
            const SizedBox(width: 5),
            Text(
              localization.delete,
              style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onPrimary),
            ),
          ],
        ),
      ),
      key: Key(recipe.id),
      onDismissed: (direction) => onDeleteTap?.call(),
      child: ListTile(
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
      ),
    );
  }
}
