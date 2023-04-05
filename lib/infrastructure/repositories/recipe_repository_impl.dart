import 'package:recipe_app/core/base/model/pagination.dart';
import 'package:recipe_app/domain/entities/recipe.dart';
import 'package:recipe_app/core/base/model/base_error.dart';
import 'package:dartz/dartz.dart';
import 'package:recipe_app/domain/entities/recipe_detail.dart';
import 'package:recipe_app/domain/entities/recipe_filter.dart';
import 'package:recipe_app/domain/repositories/recipe_repository.dart';
import 'package:recipe_app/infrastructure/data_source/recipe/recipe_local_data_source.dart';
import 'package:recipe_app/infrastructure/data_source/recipe/recipe_remote_data_source.dart';
import 'package:recipe_app/infrastructure/models/recipe_model.dart';

class RecipeRepositoryImpl extends RecipeRepository {
  RecipeRepositoryImpl(this._remoteDataSource, this._localDataSource);

  final RecipeRemoteDataSource _remoteDataSource;
  final RecipeLocalDataSource _localDataSource;

  @override
  Future<Either<BaseError, Pagination<Recipe>>> getRecipes({RecipeFilter? recipeFilter, String? nextUrl}) =>
      _remoteDataSource.fetchRecipes(recipeFilter: recipeFilter, nextUrl: nextUrl);

  @override
  Future<Either<BaseError, RecipeDetail>> getRecipeDetail(String id) => _remoteDataSource.fetchRecipeDetail(id);

  @override
  Future<int> addToFavorite(RecipeModel recipe) => _localDataSource.addToFavorite(recipe);

  @override
  Future<void>? removeFromFavorite(String id) => _localDataSource.removeFromFavorite(id);

  @override
  Recipe? getFavorite(String id) => _localDataSource.getFavorite(id);

  @override
  RecipeList getFavorites() => _localDataSource.getFavorites();
}
