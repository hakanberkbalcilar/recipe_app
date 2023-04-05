import 'package:recipe_app/core/base/model/base_view_model.dart';
import 'package:recipe_app/core/constants/routes.dart';
import 'package:recipe_app/domain/entities/recipe.dart';
import 'package:recipe_app/domain/repositories/recipe_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecipeFavoriteListViewModel extends BaseViewModel {
  RecipeFavoriteListViewModel(this._recipeRepository);

  final RecipeRepository _recipeRepository;

  RecipeList _favoriteList = [];
  RecipeList get favoriteList => _favoriteList;

  void initialize(BuildContext context) {
    if (mounted) return;

    this.context = context;
  }

  Future<void> getFavorites() async {
    _favoriteList = _recipeRepository.getFavorites();
    notifyListeners();
  }

  Future<void> showDetail(Recipe recipe) async {
    await context.pushNamed(Routes.recipe_detail, extra: recipe);
    getFavorites();
  }

  void deletefavorite(Recipe recipe) => _recipeRepository.removeFromFavorite(recipe.id);
}
