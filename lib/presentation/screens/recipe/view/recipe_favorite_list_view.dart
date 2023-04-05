import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/base/state/consumer_state_x.dart';
import 'package:recipe_app/core/constants/dimens.dart';
import 'package:recipe_app/di/repository_impl.dart';
import 'package:recipe_app/presentation/screens/recipe/view_model/recipe_favorite_list_view_model.dart';
import 'package:recipe_app/presentation/tiles/favorite_list_tile.dart';

final recipeFavoriteListView = ChangeNotifierProvider.autoDispose((ref) => RecipeFavoriteListViewModel(ref.read(recipeRepository)));

class RecipeFavoriteListView extends ConsumerStatefulWidget {
  const RecipeFavoriteListView({super.key});

  @override
  ConsumerStateX<RecipeFavoriteListView> createState() => _RecipeFavoriteListViewState();
}

class _RecipeFavoriteListViewState extends ConsumerStateX<RecipeFavoriteListView> {
  late RecipeFavoriteListViewModel viewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.getFavorites();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(recipeFavoriteListView.notifier)..initialize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localization.favorites,
        ),
      ),
      body: Consumer(builder: (context, ref, child) {
        final viewModel = ref.watch(recipeFavoriteListView);
        final favoriteList = viewModel.favoriteList;
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingPageHorizontal, vertical: Dimens.paddingPageVertical),
          itemCount: favoriteList.length,
          separatorBuilder: (context, index) => const SizedBox(height: Dimens.paddingTileBetween),
          itemBuilder: (context, index) {
            var recipe = favoriteList[index];
            return FavoriteListTile(
              recipe,
              onTap: () => viewModel.showDetail(recipe),
              onDeleteTap: () => viewModel.deletefavorite(recipe),
            );
          },
        );
      }),
    );
  }
}
