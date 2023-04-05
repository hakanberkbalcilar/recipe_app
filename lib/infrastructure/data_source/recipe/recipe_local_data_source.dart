import 'package:dartx/dartx.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/domain/entities/recipe.dart';
import 'package:recipe_app/infrastructure/models/recipe_model.dart';

class RecipeLocalDataSource {
  const RecipeLocalDataSource(this._favoriteBox);

  final Box<RecipeModel> _favoriteBox;

  Future<int> addToFavorite(RecipeModel recipe) => _favoriteBox.add(recipe);
  Future<void>? removeFromFavorite(String id) => _favoriteBox.values.firstOrNullWhere((x) => x.id == id)?.delete();

  RecipeList getFavorites() => _favoriteBox.values.toList();
  Recipe? getFavorite(String id) => _favoriteBox.values.firstOrNullWhere((x) => x.id == id);
}
