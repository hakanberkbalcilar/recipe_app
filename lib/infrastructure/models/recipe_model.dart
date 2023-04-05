import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/domain/entities/recipe.dart';
import 'package:recipe_app/domain/entities/recipe_detail.dart';

part 'recipe_model.g.dart';

@HiveType(typeId: 0)
class RecipeModel extends Recipe with HiveObjectMixin {
  RecipeModel({
    required super.id,
    required super.label,
    required super.image,
    required super.source,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    final url = Uri.parse(json['_links']['self']['href'] as String);
    return RecipeModel(
      id: url.path.replaceAll('/api/recipes/v2/', ''),
      label: json['recipe']['label'] as String,
      image: json['recipe']['image'] as String,
      source: json['recipe']['source'] as String,
    );
  }

  factory RecipeModel.fromRecipeDetail(RecipeDetail recipeDetail) => RecipeModel(
        id: recipeDetail.id,
        label: recipeDetail.label,
        image: recipeDetail.image,
        source: recipeDetail.source,
      );
}
