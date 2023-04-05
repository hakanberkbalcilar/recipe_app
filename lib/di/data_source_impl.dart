import 'package:recipe_app/core/database/database.dart';
import 'package:recipe_app/core/network/network_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/infrastructure/data_source/recipe/recipe_local_data_source.dart';
import 'package:recipe_app/infrastructure/data_source/recipe/recipe_remote_data_source.dart';

// Recipe
final recipeRemoteDataSource = Provider((ref) => RecipeRemoteDataSource(NetworkManager.instance));
final recipeLocalDataSource = Provider((ref) => RecipeLocalDataSource(Database.favorites));
