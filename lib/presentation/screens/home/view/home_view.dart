import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/core/base/state/consumer_state_x.dart';
import 'package:recipe_app/core/constants/dimens.dart';
import 'package:recipe_app/core/constants/routes.dart';
import 'package:recipe_app/core/database/database.dart';
import 'package:recipe_app/core/extensions/context_extension.dart';
import 'package:recipe_app/di/repository_impl.dart';
import 'package:recipe_app/domain/enums/cuisines.dart';
import 'package:recipe_app/domain/enums/dietary.dart';
import 'package:recipe_app/infrastructure/models/recipe_filter_model.dart';
import 'package:recipe_app/presentation/components/home_group.dart';
import 'package:recipe_app/presentation/components/loading.dart';
import 'package:recipe_app/presentation/components/search_bar.dart';
import 'package:recipe_app/presentation/screens/home/view_model/home_view_model.dart';
import 'package:recipe_app/presentation/tiles/cuisine_list_tile.dart';
import 'package:recipe_app/presentation/tiles/recipe_horizontal_list_tile.dart';

final _homeViewModel = ChangeNotifierProvider.autoDispose((ref) => HomeViewModel(ref.read(recipeRepository)));

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerStateX<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerStateX<HomeView> {
  late HomeViewModel viewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.getData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(_homeViewModel.notifier)..initialize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localization.recipes,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Container(
              height: 56,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingPageHorizontal),
              child: SearchBar(
                hintText: localization.searchRecipe,
                backgroundColor: theme.colorScheme.surface,
                readOnly: true,
                onTap: () => context.pushNamed(Routes.recipe_search),
              )),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: viewModel.getData,
        child: Consumer(
            child: const Loading(),
            builder: (context, ref, child) {
              final isLoading = ref.watch(_homeViewModel).isLoading;
              return isLoading
                  ? child!
                  : ListView(
                      padding: const EdgeInsets.symmetric(vertical: Dimens.paddingPageVertical),
                      children: [
                        SizedBox(
                          height: 40,
                          child: ListView.separated(
                            itemCount: Cuisines.values.sublist(1).length,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingPageHorizontal),
                            separatorBuilder: (context, index) => const SizedBox(width: 5),
                            itemBuilder: (context, index) {
                              final cuisine = Cuisines.values[index + 1];
                              return CuisineListTile(cuisine,
                                  onTap: () => context.pushNamed(Routes.recipe_search, extra: RecipeFilterModel(cuisine: cuisine)));
                            },
                          ),
                        ),
                        if (viewModel.veganRecipeList.isNotEmpty)
                          HomeGroup(
                              title: localization.vegan,
                              onMoreTap: () => context.pushNamed(Routes.recipe_search, extra: RecipeFilterModel(dietary: Dietary.vegan)),
                              child: SizedBox(
                                height: (context.mediaQuery.size.width * .5) * 1.5,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingPageHorizontal, vertical: Dimens.paddingTileBetween),
                                  itemCount: viewModel.veganRecipeList.length,
                                  separatorBuilder: (context, index) => const SizedBox(width: Dimens.paddingTileBetween),
                                  itemBuilder: (context, index) {
                                    var recipe = viewModel.veganRecipeList[index];
                                    recipe = Database.favorites.values.firstOrNullWhere((x) => x.id == recipe.id) ?? recipe;
                                    return RecipeHorizontalListTile(
                                      recipe,
                                      onTap: () => viewModel.showDetail(recipe),
                                      onFavoriteTap: () => viewModel.onFavoriteTap(recipe),
                                    );
                                  },
                                ),
                              )),
                        if (viewModel.glutenFreeRecipeList.isNotEmpty)
                          HomeGroup(
                              title: localization.glutenFree,
                              onMoreTap: () => context.pushNamed(Routes.recipe_search, extra: RecipeFilterModel(dietary: Dietary.glutenFree)),
                              child: SizedBox(
                                height: (context.mediaQuery.size.width * .5) * 1.5,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingPageHorizontal, vertical: Dimens.paddingTileBetween),
                                  itemCount: viewModel.glutenFreeRecipeList.length,
                                  separatorBuilder: (context, index) => const SizedBox(width: Dimens.paddingTileBetween),
                                  itemBuilder: (context, index) {
                                    var recipe = viewModel.glutenFreeRecipeList[index];
                                    recipe = Database.favorites.values.firstOrNullWhere((x) => x.id == recipe.id) ?? recipe;
                                    return RecipeHorizontalListTile(
                                      recipe,
                                      onTap: () => viewModel.showDetail(recipe),
                                      onFavoriteTap: () => viewModel.onFavoriteTap(recipe),
                                    );
                                  },
                                ),
                              )),
                        if (viewModel.vegetarianRecipeList.isNotEmpty)
                          HomeGroup(
                              title: localization.vegetarian,
                              onMoreTap: () => context.pushNamed(Routes.recipe_search, extra: RecipeFilterModel(dietary: Dietary.vegetarian)),
                              child: SizedBox(
                                height: (context.mediaQuery.size.width * .5) * 1.5,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingPageHorizontal, vertical: Dimens.paddingTileBetween),
                                  itemCount: viewModel.vegetarianRecipeList.length,
                                  separatorBuilder: (context, index) => const SizedBox(width: Dimens.paddingTileBetween),
                                  itemBuilder: (context, index) {
                                    var recipe = viewModel.vegetarianRecipeList[index];
                                    recipe = Database.favorites.values.firstOrNullWhere((x) => x.id == recipe.id) ?? recipe;
                                    return RecipeHorizontalListTile(
                                      recipe,
                                      onTap: () => viewModel.showDetail(recipe),
                                      onFavoriteTap: () => viewModel.onFavoriteTap(recipe),
                                    );
                                  },
                                ),
                              ))
                      ],
                    );
            }),
      ),
    );
  }
}
