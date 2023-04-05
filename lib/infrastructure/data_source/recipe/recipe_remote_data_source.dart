import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:recipe_app/core/base/model/base_error.dart';
import 'package:recipe_app/core/base/model/pagination.dart';
import 'package:recipe_app/core/extensions/dio_error_extension.dart';
import 'package:recipe_app/core/network/network_manager.dart';
import 'package:recipe_app/domain/entities/recipe.dart';
import 'package:recipe_app/domain/entities/recipe_detail.dart';
import 'package:recipe_app/domain/entities/recipe_filter.dart';
import 'package:recipe_app/infrastructure/models/recipe_detail_model.dart';
import 'package:recipe_app/infrastructure/models/recipe_model.dart';

const String _recipePath = 'recipes/v2/';
const String _appId = 'b0f6d013';
const String _appKey = '0bdebc604c957094923b6e54568c09fc';

class RecipeRemoteDataSource {
  const RecipeRemoteDataSource(this._networkManager);

  final NetworkManager _networkManager;

  Future<Either<BaseError, Pagination<Recipe>>> fetchRecipes({RecipeFilter? recipeFilter, String? nextUrl}) => nextUrl == null
      ? _networkManager.get(_recipePath, queryParameters: {
          'app_id': _appId,
          'app_key': _appKey,
          'type': 'public',
          if (recipeFilter?.isQueryDefault == false) 'q': recipeFilter!.query,
          if (recipeFilter?.isCuisineDefault == false) 'cuisineType': recipeFilter!.cuisine.tag,
          if (recipeFilter?.isDietaryDefault == false) 'health': recipeFilter!.dietary.tag,
          'field': [
            'image',
            'label',
            'source',
          ]
        }).then((res) => right(Pagination.fromJson(res.data, (json) => RecipeModel.fromJson(json))),
          onError: (e) => (e as DioError).toEitherBaseError<Pagination<Recipe>>())
      : _networkManager.get(nextUrl).then((res) => right(Pagination.fromJson(res.data, (json) => RecipeModel.fromJson(json))),
          onError: (e) => (e as DioError).toEitherBaseError<Pagination<Recipe>>());

  Future<Either<BaseError, RecipeDetail>> fetchRecipeDetail(String id) => _networkManager.get(_recipePath + id, queryParameters: {
        'app_id': _appId,
        'app_key': _appKey,
        'type': 'public',
        'field': [
          'image',
          'label',
          'source',
          'shareAs',
          'dietLabels',
          'healthLabels',
          'cautions',
          'ingredientLines',
          'ingredients',
          'calories',
          'totalWeight',
          'cuisineType',
          'mealType',
          'dishType',
          'instructions',
          'tags',
          'digest'
        ]
      }).then((res) => right(RecipeDetailModel.fromJson(res.data)), onError: (e) => (e as DioError).toEitherBaseError<Pagination<Recipe>>());
}
