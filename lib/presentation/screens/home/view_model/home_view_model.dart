import 'package:recipe_app/core/base/model/base_view_model.dart';
import 'package:recipe_app/core/constants/routes.dart';
import 'package:recipe_app/core/extensions/context_extension.dart';
import 'package:recipe_app/domain/entities/recipe.dart';
import 'package:recipe_app/domain/enums/dietary.dart';
import 'package:recipe_app/domain/repositories/recipe_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/infrastructure/models/recipe_filter_model.dart';
import 'package:recipe_app/infrastructure/models/recipe_model.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(this._recipeRepository);

  final RecipeRepository _recipeRepository;

  RecipeList _veganRecipeList = [];
  RecipeList get veganRecipeList => _veganRecipeList;

  RecipeList _glutenFreeRecipeList = [];
  RecipeList get glutenFreeRecipeList => _glutenFreeRecipeList;

  RecipeList _vegetarianRecipeList = [];
  RecipeList get vegetarianRecipeList => _vegetarianRecipeList;

  void initialize(BuildContext context) {
    if (mounted) return;

    this.context = context;
  }

  Future<void> getData() async {
    changeLoading(true);
    await Future.wait([_getVeganRecipes(), _getGlutenFreeRecipes(), _getVegetarianRecipes()]);
    changeLoading(false, mounted);
  }

  Future<void> _getVeganRecipes() async {
    final result = await _recipeRepository.getRecipes(recipeFilter: RecipeFilterModel(dietary: Dietary.vegan));

    result.fold((l) {
      if (!mounted) return;
      context.showSnackBar(l.toLocalizedString(context));
    }, (r) {
      _veganRecipeList = r.items;
    });
  }

  Future<void> _getGlutenFreeRecipes() async {
    final result = await _recipeRepository.getRecipes(recipeFilter: RecipeFilterModel(dietary: Dietary.glutenFree));

    result.fold((l) {
      if (!mounted) return;
      context.showSnackBar(l.toLocalizedString(context));
    }, (r) {
      _glutenFreeRecipeList = r.items;
    });
  }

  Future<void> _getVegetarianRecipes() async {
    final result = await _recipeRepository.getRecipes(recipeFilter: RecipeFilterModel(dietary: Dietary.vegetarian));

    result.fold((l) {
      if (!mounted) return;
      context.showSnackBar(l.toLocalizedString(context));
    }, (r) {
      _vegetarianRecipeList = r.items;
    });
  }

  void showDetail(Recipe recipe) => context.pushNamed(Routes.recipe_detail, extra: recipe);

  void onFavoriteTap(Recipe recipe) {
    if ((recipe as RecipeModel).isInBox) {
      recipe.delete();
    } else {
      _recipeRepository.addToFavorite(recipe);
    }

    notifyListeners();
  }
}
