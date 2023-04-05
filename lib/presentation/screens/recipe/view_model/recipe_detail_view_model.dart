import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/core/base/model/base_view_model.dart';
import 'package:recipe_app/core/constants/dimens.dart';
import 'package:recipe_app/core/extensions/context_extension.dart';
import 'package:recipe_app/domain/entities/recipe.dart';
import 'package:recipe_app/domain/entities/recipe_detail.dart';
import 'package:recipe_app/domain/repositories/recipe_repository.dart';
import 'package:recipe_app/infrastructure/models/recipe_detail_model.dart';
import 'package:recipe_app/infrastructure/models/recipe_model.dart';
import 'package:share_plus/share_plus.dart';

class RecipeDetailViewModel extends BaseViewModel {
  RecipeDetailViewModel(this._recipeRepository);

  final RecipeRepository _recipeRepository;

  RecipeDetail? _recipeDetail;
  RecipeDetail get recipeDetail => _recipeDetail!;

  List<double> _titleOffsetList = [];
  List<double> get titleOffsetList => _titleOffsetList;

  bool _isAnimationRunning = false;
  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  final double titleHeaderHeight = 60;
  double get appBarExpandedHeight => context.mediaQuery.size.height * .4 + titleHeaderHeight;

  final scrollController = ScrollController();

  void initialize(BuildContext context, Recipe recipe) {
    if (mounted) return;

    this.context = context;
    _recipeDetail = RecipeDetailModel.fromRecipe(recipe);
    scrollController.removeListener(_onScrollTriggered);
    scrollController.addListener(_onScrollTriggered);
  }

  Future<void> getData() async {
    changeLoading(true);
    final result = await _recipeRepository.getRecipeDetail(recipeDetail.id);

    result.fold((l) {
      if (!mounted) return;
      changeLoading(false, mounted);
      context.showSnackBar(l.toLocalizedString(context));
      context.pop();
    }, (r) {
      _recipeDetail = r;
      _isFavorite = _recipeRepository.getFavorite(recipeDetail.id) != null;

      _calculateTitleOffsets();
      changeLoading(false, mounted);
    });
  }

  _calculateTitleOffsets() {
    final tabLength = DefaultTabController.of(context).length;
    final appBarExpandedHeight = this.appBarExpandedHeight;
    final appBarOffset = (appBarExpandedHeight - 56);
    _titleOffsetList = List.generate(tabLength, (index) {
      final totalTopPadding = Dimens.paddingTileBetween * index * 2;
      final totalTitleHeight = index * 54;
      final totalItemHeight = index == 0 ? 0 : recipeDetail.ingredients.fold<double>(0, (previousValue, element) => previousValue + 75.65);
      return appBarOffset + totalTitleHeight + totalItemHeight + totalTopPadding;
    });
  }

  Future<void> share() => Share.share(recipeDetail.shareAs);

  void onTabChanged(int value) async {
    _isAnimationRunning = true;
    await scrollController.animateTo(titleOffsetList[value], duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    _isAnimationRunning = false;
  }

  void _onScrollTriggered() {
    if (_isAnimationRunning) return;

    final offset = scrollController.offset;
    final currentIndex = titleOffsetList.lastIndexWhere((x) => x < offset);

    if (currentIndex == -1 || currentIndex == DefaultTabController.of(context).index) return;

    DefaultTabController.of(context).animateTo(currentIndex, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void onFavoriteTap() {
    if (_isFavorite) {
      _recipeRepository.removeFromFavorite(recipeDetail.id);
    } else {
      _recipeRepository.addToFavorite(RecipeModel.fromRecipeDetail(recipeDetail));
    }

    _isFavorite = !_isFavorite;
    notifyListeners();
  }
}
