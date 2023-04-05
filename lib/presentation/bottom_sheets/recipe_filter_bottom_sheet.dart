import 'package:flutter/material.dart';
import 'package:recipe_app/core/base/state/state_x.dart';
import 'package:recipe_app/core/constants/dimens.dart';
import 'package:recipe_app/domain/entities/recipe_filter.dart';
import 'package:recipe_app/domain/enums/cuisines.dart';
import 'package:recipe_app/domain/enums/dietary.dart';
import 'package:recipe_app/infrastructure/models/recipe_filter_model.dart';
import 'package:recipe_app/presentation/components/button_x.dart';

class RecipeFilterBottomSheet extends StatefulWidget {
  const RecipeFilterBottomSheet(this.recipeFilter, {super.key});

  final RecipeFilter recipeFilter;

  @override
  StateX<RecipeFilterBottomSheet> createState() => _RecipeFilterBottomSheetState();
}

class _RecipeFilterBottomSheetState extends StateX<RecipeFilterBottomSheet> {
  late Cuisines cuisine = widget.recipeFilter.cuisine;
  late Dietary dietary = widget.recipeFilter.dietary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          toolbarHeight: 70,
          backgroundColor: theme.colorScheme.surface,
          title: Text(localization.filter),
          scrolledUnderElevation: 0,
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingPageHorizontal, vertical: Dimens.paddingPageVertical),
                  shrinkWrap: true,
                  children: [
                    DropdownButtonFormField(
                        value: cuisine,
                        decoration: InputDecoration(labelText: localization.cuisines),
                        items: Cuisines.values.map((e) => DropdownMenuItem(value: e, child: Text(e.toLocalizedString(context)))).toList(),
                        onChanged: (value) => setState(() => cuisine = value ?? cuisine)),
                    const SizedBox(height: Dimens.paddingTileBetween),
                    DropdownButtonFormField(
                        value: dietary,
                        decoration: InputDecoration(labelText: localization.dietary),
                        items: Dietary.values.map((e) => DropdownMenuItem(value: e, child: Text(e.toLocalizedString(context)))).toList(),
                        onChanged: (value) => setState(() => dietary = value ?? dietary))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(Dimens.paddingPageHorizontal, Dimens.paddingPageVertical, Dimens.paddingPageHorizontal,
                    Dimens.paddingPageVertical + mediaQuery.padding.bottom),
                child: Row(
                  children: [
                    Expanded(
                        child: ButtonX(
                      backgroundColor: theme.colorScheme.background,
                      foregroundColor: theme.colorScheme.onBackground,
                      text: localization.defaultText,
                      onTap: () => Navigator.of(context).pop(RecipeFilterModel(query: widget.recipeFilter.query)),
                    )),
                    const SizedBox(width: Dimens.paddingTileBetween),
                    Expanded(
                        child: ButtonX(
                      text: localization.apply,
                      onTap: () => Navigator.of(context).pop(widget.recipeFilter.copyWith(cuisine: cuisine, dietary: dietary)),
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
