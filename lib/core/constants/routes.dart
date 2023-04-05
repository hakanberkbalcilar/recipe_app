// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart' hide Table;
import 'package:go_router/go_router.dart';
import 'package:recipe_app/domain/entities/recipe.dart';
import 'package:recipe_app/domain/entities/recipe_filter.dart';
import 'package:recipe_app/presentation/screens/navigation/view/navigation_view.dart';
import 'package:recipe_app/presentation/screens/recipe/view/recipe_detail_view.dart';
import 'package:recipe_app/presentation/screens/recipe/view/recipe_search_view.dart';
import 'package:recipe_app/presentation/screens/settings/view/about_view.dart';
import 'package:recipe_app/presentation/screens/settings/view/settings_language_view.dart';
import 'package:recipe_app/presentation/screens/settings/view/settings_theme_view.dart';

class Routes {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static const String favorites = "favorites";
  static const String recipes = "recipes";
  static const String recipe_detail = "recipe_detail";
  static const String recipe_search = "recipe_search";
  static const String settings = "settings";
  static const String themeSettings = "themeSettings";
  static const String languageSettings = "languageSettings";
  static const String about = "about";

  static final routerConfig = GoRouter(navigatorKey: rootNavigatorKey, initialLocation: '/recipes', routes: [
    GoRoute(
      name: favorites,
      path: '/favorites',
      pageBuilder: (context, state) => const NoTransitionPage(child: NavigationView(favorites)),
    ),
    GoRoute(
      name: recipes,
      path: '/recipes',
      pageBuilder: (context, state) => const NoTransitionPage(child: NavigationView(recipes)),
      routes: [
        GoRoute(
          name: recipe_detail,
          path: recipe_detail,
          builder: (context, state) => RecipeDetailView(state.extra as Recipe),
        ),
        GoRoute(
          name: recipe_search,
          path: recipe_search,
          builder: (context, state) => RecipeSearchView(
            recipeFilter: state.extra as RecipeFilter?,
          ),
        )
      ],
    ),
    GoRoute(
      name: settings,
      path: '/settings',
      pageBuilder: (context, state) => const NoTransitionPage(child: NavigationView(settings)),
      routes: [
        GoRoute(
          name: themeSettings,
          path: themeSettings,
          builder: (context, state) => const SettingsThemeView(),
        ),
        GoRoute(
          name: languageSettings,
          path: languageSettings,
          builder: (context, state) => const SettingsLanguageView(),
        ),
        GoRoute(
          name: about,
          path: about,
          builder: (context, state) => const AboutView(),
        ),
      ],
    )
  ]);
}
