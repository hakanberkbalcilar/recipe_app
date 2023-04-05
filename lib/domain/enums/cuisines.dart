import 'package:flutter/material.dart';
import 'package:recipe_app/core/extensions/context_extension.dart';

enum Cuisines {
  none('None'),
  american('American'),
  asian('Asian'),
  british('British'),
  caribbean('Caribbean'),
  centralEurope('Central Europe'),
  chinese('Chinese'),
  easternEurope('Eastern Europe'),
  french('French'),
  indian('Indian'),
  italian('Italian'),
  japanese('Japanese'),
  kosher('Kosher'),
  mediterranean('Mediterranean'),
  mexican('Mexican'),
  middleEastern('Middle Eastern'),
  nordic('Nordic'),
  southAmerican('South American'),
  southEastAsian('South East Asian');

  const Cuisines(this.tag);

  final String tag;

  String toLocalizedString(BuildContext context) {
    final localization = context.localization;

    switch (this) {
      case Cuisines.american:
        return localization.american;
      case Cuisines.asian:
        return localization.asian;
      case Cuisines.british:
        return localization.british;
      case Cuisines.caribbean:
        return localization.caribbean;
      case Cuisines.centralEurope:
        return localization.centralEurope;
      case Cuisines.chinese:
        return localization.chinese;
      case Cuisines.easternEurope:
        return localization.easternEurope;
      case Cuisines.french:
        return localization.french;
      case Cuisines.indian:
        return localization.indian;
      case Cuisines.italian:
        return localization.italian;
      case Cuisines.japanese:
        return localization.japanese;
      case Cuisines.kosher:
        return localization.kosher;
      case Cuisines.mediterranean:
        return localization.mediterranean;
      case Cuisines.mexican:
        return localization.mexican;
      case Cuisines.middleEastern:
        return localization.middleEastern;
      case Cuisines.nordic:
        return localization.nordic;
      case Cuisines.southAmerican:
        return localization.southAmerican;
      case Cuisines.southEastAsian:
        return localization.southEastAsian;
      default:
        return localization.none;
    }
  }
}
