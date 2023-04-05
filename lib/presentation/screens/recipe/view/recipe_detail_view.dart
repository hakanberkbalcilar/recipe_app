import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/core/base/state/consumer_state_x.dart';
import 'package:recipe_app/core/constants/dimens.dart';
import 'package:recipe_app/core/extensions/num_extension.dart';
import 'package:recipe_app/di/repository_impl.dart';
import 'package:recipe_app/domain/entities/recipe.dart';
import 'package:recipe_app/presentation/components/loading.dart';
import 'package:recipe_app/presentation/components/vertical_tab_view.dart';
import 'package:recipe_app/presentation/delegates/sliver_header_delegate.dart';
import 'package:recipe_app/presentation/screens/recipe/view_model/recipe_detail_view_model.dart';
import 'package:recipe_app/presentation/tiles/ingredient_list_tile.dart';
import 'package:recipe_app/presentation/tiles/instruction_list_tile.dart';

final _recipeDetailViewModel = ChangeNotifierProvider.autoDispose((ref) => RecipeDetailViewModel(ref.read(recipeRepository)));

class RecipeDetailView extends ConsumerStatefulWidget {
  const RecipeDetailView(this.recipe, {super.key});

  final Recipe recipe;

  @override
  ConsumerStateX<RecipeDetailView> createState() => _RecipeDetailViewState();
}

class _RecipeDetailViewState extends ConsumerStateX<RecipeDetailView> {
  late RecipeDetailViewModel viewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(builder: (context) {
        viewModel = ref.watch(_recipeDetailViewModel.notifier)..initialize(context, widget.recipe);
        final isLoading = ref.watch(_recipeDetailViewModel.select((value) => value.isLoading));
        final recipeDetail = viewModel.recipeDetail;
        return Scaffold(
          backgroundColor: theme.colorScheme.surface,
          body: CustomScrollView(
            controller: viewModel.scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: theme.colorScheme.surface,
                expandedHeight: viewModel.appBarExpandedHeight,
                leading: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: FloatingActionButton(
                        onPressed: context.pop,
                        mini: true,
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ],
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: FloatingActionButton(
                      onPressed: viewModel.share,
                      mini: true,
                      heroTag: null,
                      child: const Icon(Icons.share),
                    ),
                  )
                ],
                flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                  return FlexibleSpaceBar(
                    title: constraints.maxHeight <= (mediaQuery.padding.top + viewModel.titleHeaderHeight + Dimens.paddingPageVertical)
                        ? Text(
                            recipeDetail.label,
                            style: TextStyle(color: theme.appBarTheme.foregroundColor, fontSize: 20),
                            maxLines: 1,
                          )
                        : null,
                    background: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          foregroundDecoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, theme.colorScheme.surface])),
                          child: Image.network(
                            recipeDetail.image,
                            fit: BoxFit.cover,
                            width: double.maxFinite,
                            height: mediaQuery.size.height * .4,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: theme.colorScheme.surface,
                            padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingPageHorizontal),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: Dimens.paddingPageVertical),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        recipeDetail.label,
                                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
                                        maxLines: 1,
                                      ),
                                    ),
                                    Consumer(builder: (context, ref, _) {
                                      final isFavorite = ref.watch(_recipeDetailViewModel.select((value) => value.isFavorite));
                                      return IconButton(
                                        onPressed: viewModel.onFavoriteTap,
                                        icon: Icon(isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded),
                                        style: IconButton.styleFrom(
                                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            foregroundColor: isFavorite ? theme.colorScheme.primary : null),
                                      );
                                    })
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(recipeDetail.source),
                                    const Spacer(),
                                    Text(recipeDetail.calories.toFixedString(sign: ' cal')),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
              ...isLoading
                  ? [const SliverFillRemaining(child: Loading())]
                  : [
                      SliverPersistentHeader(
                          pinned: true,
                          delegate: SliverHeaderDelegate(
                            builder: (context, shrinkOffset, overlapsContent) {
                              return Container(
                                decoration: BoxDecoration(color: theme.colorScheme.surface),
                                child: TabBar(
                                  dividerColor: Colors.transparent,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: Dimens.paddingTabBarHorizontal, vertical: Dimens.paddingTabBarVertical),
                                  tabs: [Tab(text: localization.ingredients), Tab(text: localization.instructions)],
                                  onTap: viewModel.onTabChanged,
                                ),
                              );
                            },
                          )),
                      SliverList(
                          delegate: SliverChildListDelegate([
                        VerticalTabView(title: localization.ingredients, child: const RecipeDetailIngredientListView()),
                        VerticalTabView(title: localization.instructions, child: const RecipeDetailInstructionListView()),
                      ])),
                    ],
            ],
          ),
        );
      }),
    );
  }
}

class RecipeDetailIngredientListView extends ConsumerWidget {
  const RecipeDetailIngredientListView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ref.watch(_recipeDetailViewModel.notifier);
    final isLoading = ref.watch(_recipeDetailViewModel.select((value) => value.isLoading));
    final ingredientList = viewModel.recipeDetail.ingredients;
    return isLoading
        ? const Loading()
        : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: Dimens.paddingTileBetween),
            itemCount: ingredientList.length,
            separatorBuilder: (context, index) => const SizedBox(height: Dimens.paddingTileBetween),
            itemBuilder: (context, index) {
              final ingredient = ingredientList[index];
              return IngredientListTile(ingredient);
            },
          );
  }
}

class RecipeDetailInstructionListView extends ConsumerWidget {
  const RecipeDetailInstructionListView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ref.watch(_recipeDetailViewModel.notifier);
    final isLoading = ref.watch(_recipeDetailViewModel.select((value) => value.isLoading));
    final instructionList = viewModel.recipeDetail.ingredientLines;
    return isLoading
        ? const Loading()
        : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: Dimens.paddingTileBetween),
            itemCount: instructionList.length,
            separatorBuilder: (context, index) => const SizedBox(height: Dimens.paddingTileBetween),
            itemBuilder: (context, index) {
              final instruction = instructionList[index];
              return InstructionListTile(index, instruction);
            },
          );
  }
}
