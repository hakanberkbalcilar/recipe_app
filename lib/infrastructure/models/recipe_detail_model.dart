import 'package:recipe_app/domain/entities/recipe.dart';
import 'package:recipe_app/domain/entities/recipe_detail.dart';
import 'package:recipe_app/infrastructure/models/recipe_digest_model.dart';
import 'package:recipe_app/infrastructure/models/recipe_ingredient_model.dart';

class RecipeDetailModel extends RecipeDetail {
  RecipeDetailModel({
    required super.id,
    required super.label,
    required super.image,
    required super.source,
    required super.shareAs,
    required super.dietLabels,
    required super.healthLabels,
    required super.cautions,
    required super.ingredientLines,
    required super.ingredients,
    required super.calories,
    required super.totalWeight,
    required super.cuisineType,
    required super.mealType,
    required super.dishType,
    required super.tags,
    required super.digest,
  });

  factory RecipeDetailModel.fromJson(Map<String, dynamic> json) {
    final url = Uri.parse(json['_links']['self']['href'] as String);
    return RecipeDetailModel(
      id: url.path.replaceAll('/api/recipes/v2/', ''),
      label: json['recipe']['label'] as String,
      image: json['recipe']['image'] as String,
      source: json['recipe']['source'] as String,
      shareAs: json['recipe']['shareAs'] as String,
      dietLabels: List.castFrom<dynamic, String>(json['recipe']['dietLabels']),
      healthLabels: List.castFrom<dynamic, String>(json['recipe']['healthLabels']),
      cautions: List.castFrom<dynamic, String>(json['recipe']['cautions']),
      ingredientLines: List.castFrom<dynamic, String>(json['recipe']['ingredientLines']),
      ingredients: List.from(json['recipe']['ingredients']).map((e) => RecipeIngredientModel.fromJson(e)).toList(),
      calories: (json['recipe']['calories'] as num).toDouble(),
      totalWeight: (json['recipe']['totalWeight'] as num).toDouble(),
      cuisineType: List.castFrom<dynamic, String>(json['recipe']['cuisineType']),
      mealType: List.castFrom<dynamic, String>(json['recipe']['mealType']),
      dishType: List.castFrom<dynamic, String>(json['recipe']['dishType']),
      tags: (json['recipe']['tags'] as List?)?.cast() ?? [],
      digest: List.from(json['recipe']['digest']).map((e) => RecipeDigestModel.fromJson(e)).toList(),
    );
  }

  factory RecipeDetailModel.fromRecipe(Recipe recipe) => RecipeDetailModel(
        id: recipe.id,
        label: recipe.label,
        image: recipe.image,
        source: recipe.source,
        shareAs: '',
        dietLabels: [],
        healthLabels: [],
        cautions: [],
        ingredientLines: [],
        ingredients: [],
        calories: 0,
        totalWeight: 0,
        cuisineType: [],
        mealType: [],
        dishType: [],
        tags: [],
        digest: [],
      );
}
