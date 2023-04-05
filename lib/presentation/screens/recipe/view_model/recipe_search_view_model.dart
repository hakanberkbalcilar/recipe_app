import 'dart:async';
import 'package:recipe_app/core/base/model/base_view_model.dart';
import 'package:recipe_app/core/base/model/pagination.dart';
import 'package:recipe_app/core/constants/routes.dart';
import 'package:recipe_app/core/extensions/context_extension.dart';
import 'package:recipe_app/domain/entities/recipe.dart';
import 'package:recipe_app/domain/entities/recipe_filter.dart';
import 'package:recipe_app/domain/repositories/recipe_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/infrastructure/models/recipe_filter_model.dart';
import 'package:recipe_app/infrastructure/models/recipe_model.dart';
import 'package:recipe_app/presentation/bottom_sheets/recipe_filter_bottom_sheet.dart';

class RecipeSearchViewModel extends BaseViewModel {
  RecipeSearchViewModel(this._recipeRepository);

  final RecipeRepository _recipeRepository;

  Pagination<Recipe> _data = Pagination(next: null, itemCount: 0, items: []);

  RecipeList get recipeList => _data.items;

  Timer? _timer;

  bool _isFetchingData = false;
  RecipeFilter? _recipeFilter;
  RecipeFilter get recipeFilter => _recipeFilter!;

  late final ScrollController scrollController = ScrollController()..addListener(_scrollListener);

  void initialize(BuildContext context, RecipeFilter? recipeFilter) {
    if (mounted) return;
    this.context = context;
    _recipeFilter = recipeFilter ?? RecipeFilterModel();
  }

  Future<void> getRecipes({String? nextUrl}) async {
    changeLoading(nextUrl == null);
    final result = await _recipeRepository.getRecipes(recipeFilter: recipeFilter, nextUrl: nextUrl);

    result.fold((l) {
      if (!mounted) return;
      changeLoading(false, mounted);
      context.showSnackBar(l.toLocalizedString(context));
      _isFetchingData = false;
    }, (r) {
      _data = nextUrl == null ? r : _data.merge(r);
      changeLoading(false, mounted);
      _isFetchingData = false;
    });
  }

  void showDetail(Recipe recipe) => context.pushNamed(Routes.recipe_detail, extra: recipe);

  void search(String value) {
    if (_timer?.isActive == true) _timer!.cancel();

    _timer = Timer(const Duration(seconds: 1), () {
      _recipeFilter = _recipeFilter?.copyWith(query: value);
      getRecipes();
    });
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 500 && _data.next != null && !_isFetchingData) {
      _isFetchingData = true;
      getRecipes(nextUrl: _data.next);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> showFilter() async {
    final result = await showModalBottomSheet<RecipeFilterModel>(
      context: context,
      elevation: 0,
      builder: (context) => RecipeFilterBottomSheet(recipeFilter),
    );
    if (result == null) return;

    _recipeFilter = result;
    notifyListeners();
    getRecipes();
  }

  void onFavoriteTap(Recipe recipe) {
    if ((recipe as RecipeModel).isInBox) {
      recipe.delete();
    } else {
      _recipeRepository.addToFavorite(recipe);
    }

    notifyListeners();
  }
}
