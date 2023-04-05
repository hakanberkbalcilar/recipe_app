import 'package:recipe_app/domain/enums/cuisines.dart';
import 'package:recipe_app/domain/enums/dietary.dart';
import 'package:recipe_app/infrastructure/models/recipe_filter_model.dart';

abstract class RecipeFilter {
  final Cuisines cuisine;
  final Dietary dietary;
  final String query;

  RecipeFilter({required this.cuisine, required this.dietary, required this.query});

  bool get isCuisineDefault => cuisine == Cuisines.none;
  bool get isDietaryDefault => dietary == Dietary.none;
  bool get isQueryDefault => query.isEmpty;
  bool get isAllDefault => isCuisineDefault && isDietaryDefault && isQueryDefault;
  bool get isAllDefaultInsteadQuery => isCuisineDefault && isDietaryDefault;

  RecipeFilter copyWith({Cuisines? cuisine, Dietary? dietary, String? query}) => RecipeFilterModel(
        cuisine: cuisine ?? this.cuisine,
        dietary: dietary ?? this.dietary,
        query: query ?? this.query,
      );
}
