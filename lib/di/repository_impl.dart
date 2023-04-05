import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/di/data_source_impl.dart';
import 'package:recipe_app/infrastructure/repositories/recipe_repository_impl.dart';

// Recipe
final recipeRepository = Provider((ref) => RecipeRepositoryImpl(ref.read(recipeRemoteDataSource), ref.read(recipeLocalDataSource)));
