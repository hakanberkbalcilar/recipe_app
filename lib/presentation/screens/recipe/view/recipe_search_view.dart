import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/base/state/consumer_state_x.dart';
import 'package:recipe_app/core/constants/dimens.dart';
import 'package:recipe_app/core/database/database.dart';
import 'package:recipe_app/di/repository_impl.dart';
import 'package:recipe_app/domain/entities/recipe_filter.dart';
import 'package:recipe_app/presentation/components/loading.dart';
import 'package:recipe_app/presentation/components/search_bar.dart';
import 'package:recipe_app/presentation/screens/recipe/view_model/recipe_search_view_model.dart';
import 'package:recipe_app/presentation/tiles/recipe_list_tile.dart';

final _recipeSearchViewModel = ChangeNotifierProvider.autoDispose((ref) => RecipeSearchViewModel(ref.read(recipeRepository)));

class RecipeSearchView extends ConsumerStatefulWidget {
  const RecipeSearchView({super.key, this.recipeFilter});

  final RecipeFilter? recipeFilter;

  @override
  ConsumerStateX<RecipeSearchView> createState() => _RecipeSearchViewState();
}

class _RecipeSearchViewState extends ConsumerStateX<RecipeSearchView> {
  late RecipeSearchViewModel viewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.getRecipes();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(_recipeSearchViewModel.notifier)..initialize(context, widget.recipeFilter);
    return Scaffold(
      appBar: AppBar(
        title: Consumer(builder: (context, ref, _) {
          final isFilterDefault = ref.watch(_recipeSearchViewModel.select((value) => value.recipeFilter.isAllDefaultInsteadQuery));
          return Row(
            children: [
              Expanded(
                child: SearchBar(
                  hintText: localization.searchRecipe,
                  backgroundColor: theme.colorScheme.surface,
                  onChanged: viewModel.search,
                ),
              ),
              IconButton(
                onPressed: viewModel.showFilter,
                icon: Badge(
                  smallSize: 8,
                  isLabelVisible: !isFilterDefault,
                  child: const Icon(Icons.filter_alt_outlined),
                ),
                style: IconButton.styleFrom(fixedSize: const Size.square(52)),
              ),
            ],
          );
        }),
      ),
      body: Consumer(
          child: const Loading(),
          builder: (context, ref, child) {
            final isLoading = ref.watch(_recipeSearchViewModel).isLoading;
            final recipeList = viewModel.recipeList;
            return isLoading
                ? child!
                : ListView.separated(
                    controller: viewModel.scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingPageHorizontal, vertical: Dimens.paddingPageVertical),
                    itemCount: recipeList.length,
                    separatorBuilder: (context, index) => const SizedBox(height: Dimens.paddingTileBetween),
                    itemBuilder: (context, index) {
                      var recipe = recipeList[index];
                      recipe = Database.favorites.values.firstOrNullWhere((x) => x.id == recipe.id) ?? recipe;
                      return RecipeListTile(
                        recipe,
                        onTap: () => viewModel.showDetail(recipe),
                        onFavoriteTap: () => viewModel.onFavoriteTap(recipe),
                      );
                    },
                  );
          }),
    );
  }
}
