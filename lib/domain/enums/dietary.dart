import 'package:flutter/material.dart';
import 'package:recipe_app/core/extensions/context_extension.dart';

enum Dietary {
  none('none'),
  alcoholCocktail('alcohol-cocktail'),
  alcoloFree('alcohol-free'),
  celeryFree('celery-free'),
  crustaceanFree('crustacean-free'),
  dairyFree('dairy-free'),
  dash('DASH'),
  eggFree('egg-free'),
  fishFree('fish-free'),
  fodmapFree('fodmap-free'),
  glutenFree('gluten-free'),
  immunoSupportive('immuno-supportive'),
  ketoFriendly('keto-friendly'),
  kidneyFriendly('kidney-friendly'),
  lowFatAbs('low-fat-abs'),
  lowPotassium('low-potassium'),
  lowSugar('low-sugar'),
  lupineFree('lupine-free'),
  molluskFree('mollusk-free'),
  mustardFree('mustard-free'),
  noOil('no-oil-added'),
  paleo('paleo'),
  peanutFree('peanut-free'),
  pescatarian('pescatarian'),
  porkFree('pork-free'),
  redMeatFree('red-meat-free'),
  sesameFree('sesame-free'),
  shellfishFree('shellfish-free'),
  soyFree('soy-free'),
  sugarConscious('sugar-conscious'),
  sulfiteFree('sulfite-free'),
  treeNutFree('tree-nut-free'),
  vegan('vegan'),
  vegetarian('vegetarian'),
  wheatFree('wheat-free');

  const Dietary(this.tag);

  final String tag;

  String toLocalizedString(BuildContext context) {
    final localization = context.localization;

    switch (this) {
      case Dietary.alcoholCocktail:
        return localization.alcoholCocktail;
      case Dietary.alcoloFree:
        return localization.alcoloFree;
      case Dietary.celeryFree:
        return localization.celeryFree;
      case Dietary.crustaceanFree:
        return localization.crustaceanFree;
      case Dietary.dairyFree:
        return localization.dairyFree;
      case Dietary.dash:
        return localization.dash;
      case Dietary.eggFree:
        return localization.eggFree;
      case Dietary.fishFree:
        return localization.fishFree;
      case Dietary.fodmapFree:
        return localization.fodmapFree;
      case Dietary.glutenFree:
        return localization.glutenFree;
      case Dietary.immunoSupportive:
        return localization.immunoSupportive;
      case Dietary.ketoFriendly:
        return localization.ketoFriendly;
      case Dietary.kidneyFriendly:
        return localization.kidneyFriendly;
      case Dietary.lowFatAbs:
        return localization.lowFatAbs;
      case Dietary.lowPotassium:
        return localization.lowPotassium;
      case Dietary.lowSugar:
        return localization.lowSugar;
      case Dietary.lupineFree:
        return localization.lupineFree;
      case Dietary.molluskFree:
        return localization.molluskFree;
      case Dietary.mustardFree:
        return localization.mustardFree;
      case Dietary.noOil:
        return localization.noOil;
      case Dietary.paleo:
        return localization.paleo;
      case Dietary.peanutFree:
        return localization.peanutFree;
      case Dietary.pescatarian:
        return localization.pescatarian;
      case Dietary.porkFree:
        return localization.porkFree;
      case Dietary.redMeatFree:
        return localization.redMeatFree;
      case Dietary.sesameFree:
        return localization.sesameFree;
      case Dietary.shellfishFree:
        return localization.shellfishFree;
      case Dietary.soyFree:
        return localization.soyFree;
      case Dietary.sugarConscious:
        return localization.sugarConscious;
      case Dietary.sulfiteFree:
        return localization.sulfiteFree;
      case Dietary.treeNutFree:
        return localization.treeNutFree;
      case Dietary.vegan:
        return localization.vegan;
      case Dietary.vegetarian:
        return localization.vegetarian;
      case Dietary.wheatFree:
        return localization.wheatFree;
      default:
        return localization.none;
    }
  }
}
