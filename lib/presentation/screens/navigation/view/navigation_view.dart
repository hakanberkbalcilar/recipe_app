import 'package:recipe_app/core/base/state/consumer_state_x.dart';
import 'package:recipe_app/core/constants/routes.dart';
import 'package:recipe_app/presentation/screens/recipe/view/recipe_favorite_list_view.dart';
import 'package:recipe_app/presentation/screens/navigation/view_model/navigation_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/presentation/screens/home/view/home_view.dart';
import 'package:recipe_app/presentation/screens/settings/view/settings_view.dart';

final _navigationViewModel = ChangeNotifierProvider.autoDispose((ref) => NavigationViewModel());

class NavigationView extends ConsumerStatefulWidget {
  const NavigationView(this.tab, {super.key});

  final String tab;

  @override
  ConsumerStateX<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends ConsumerStateX<NavigationView> {
  late NavigationViewModel viewModel;

  int get selectedIndex {
    switch (widget.tab) {
      case Routes.favorites:
        return 0;
      case Routes.recipes:
        return 1;
      case Routes.settings:
        return 2;
      default:
        return 0;
    }
  }

  String nameFromIndex(int index) {
    switch (index) {
      case 0:
        return Routes.favorites;
      case 1:
        return Routes.recipes;
      case 2:
        return Routes.settings;
      default:
        return Routes.recipes;
    }
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(_navigationViewModel.notifier)..initialize(context);
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: const [RecipeFavoriteListView(), HomeView(), SettingsView()],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        destinations: [
          NavigationDestination(
              selectedIcon: const Icon(Icons.favorite_rounded), icon: const Icon(Icons.favorite_border_rounded), label: localization.favorites),
          NavigationDestination(
              selectedIcon: const Icon(Icons.soup_kitchen_rounded), icon: const Icon(Icons.soup_kitchen_outlined), label: localization.recipes),
          NavigationDestination(
              selectedIcon: const Icon(Icons.settings_rounded), icon: const Icon(Icons.settings_outlined), label: localization.settings),
        ],
        onDestinationSelected: (value) {
          context.goNamed(nameFromIndex(value));
          if (value == 0) ref.read(recipeFavoriteListView).getFavorites();
        },
      ),
    );
  }
}
