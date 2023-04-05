typedef RecipeIngredientList = List<RecipeIngredient>;

abstract class RecipeIngredient {
  RecipeIngredient({
    required this.text,
    required this.quantity,
    required this.measure,
    required this.food,
    required this.weight,
    required this.foodId,
  });
  final String text;
  final double quantity;
  final String measure;
  final String food;
  final double weight;
  final String foodId;
}
