import 'package:recipe_app/domain/entities/recipe_ingredient.dart';

class RecipeIngredientModel extends RecipeIngredient {
  RecipeIngredientModel({
    required super.text,
    required super.quantity,
    required super.measure,
    required super.food,
    required super.weight,
    required super.foodId,
  });

  factory RecipeIngredientModel.fromJson(Map<String, dynamic> json) => RecipeIngredientModel(
        text: json['text'] as String,
        quantity: (json['quantity'] as num).toDouble(),
        measure: json['measure'] as String? ?? '',
        food: json['food'] as String,
        weight: (json['weight'] as num).toDouble(),
        foodId: json['foodId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'quantity': quantity,
        'measure': measure,
        'food': food,
        'weight': weight,
        'foodId': foodId,
      };
}
