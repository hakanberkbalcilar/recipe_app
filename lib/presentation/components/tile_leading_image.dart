import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/dimens.dart';
import 'package:recipe_app/core/extensions/context_extension.dart';
import 'package:recipe_app/core/extensions/num_extension.dart';

class TileLeadingImage extends StatelessWidget {
  const TileLeadingImage(this.image, {super.key});

  final String image;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      width: 56,
      height: 56,
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: Dimens.radiusLeading.toBorderRadius(),
        color: theme.colorScheme.background,
      ),
      child: Image.network(
        image,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) =>
            loadingProgress?.expectedTotalBytes == loadingProgress?.cumulativeBytesLoaded ? child : const Icon(Icons.dinner_dining_rounded),
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.dinner_dining_rounded),
      ),
    );
  }
}
