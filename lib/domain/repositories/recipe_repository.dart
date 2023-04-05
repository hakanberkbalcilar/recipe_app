import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/base/model/base_error.dart';
import 'package:recipe_app/core/base/model/pagination.dart';
import 'package:recipe_app/domain/entities/recipe.dart';
import 'package:recipe_app/domain/entities/recipe_detail.dart';
import 'package:recipe_app/domain/entities/recipe_filter.dart';
import 'package:recipe_app/infrastructure/models/recipe_model.dart';

abstract class RecipeRepository {
  Future<Either<BaseError, Pagination<Recipe>>> getRecipes({RecipeFilter? recipeFilter, String? nextUrl});
  Future<Either<BaseError, RecipeDetail>> getRecipeDetail(String id);
  RecipeList getFavorites();
  Recipe? getFavorite(String id);
  Future<int> addToFavorite(RecipeModel recipe);
  Future<void>? removeFromFavorite(String id);
}
