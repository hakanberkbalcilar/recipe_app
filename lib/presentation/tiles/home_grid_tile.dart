import 'package:recipe_app/core/constants/dimens.dart';
import 'package:recipe_app/core/extensions/context_extension.dart';
import 'package:recipe_app/core/extensions/num_extension.dart';
import 'package:flutter/material.dart';

class HomeGridTile extends StatelessWidget {
  const HomeGridTile({super.key, required this.image, required this.title, this.onTap});

  final String image;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: Dimens.radiusTile.toBorderRadius(),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.paddingTile),
          child: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(Dimens.paddingTile * 2),
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              )),
              SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
