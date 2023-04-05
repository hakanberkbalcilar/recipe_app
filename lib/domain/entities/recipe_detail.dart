import 'package:recipe_app/domain/entities/recipe_digest.dart';
import 'package:recipe_app/domain/entities/recipe_ingredient.dart';

abstract class RecipeDetail {
  RecipeDetail({
    required this.id,
    required this.label,
    required this.image,
    required this.source,
    required this.shareAs,
    required this.dietLabels,
    required this.healthLabels,
    required this.cautions,
    required this.ingredientLines,
    required this.ingredients,
    required this.calories,
    required this.totalWeight,
    required this.cuisineType,
    required this.mealType,
    required this.dishType,
    required this.tags,
    required this.digest,
  });

  final String id;
  final String label;
  final String image;
  final String source;
  final String shareAs;
  final List<String> dietLabels;
  final List<String> healthLabels;
  final List<String> cautions;
  final List<String> ingredientLines;
  final RecipeIngredientList ingredients;
  final double calories;
  final double totalWeight;
  final List<String> cuisineType;
  final List<String> mealType;
  final List<String> dishType;
  final List<String> tags;
  final RecipeDigestList digest;
}
