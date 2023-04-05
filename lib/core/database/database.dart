import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/infrastructure/models/recipe_model.dart';

const _settingBoxName = 'settings';
const _favoriteBoxName = 'favorites';

class Database {
  static Box<dynamic> get settings => Hive.box<dynamic>(_settingBoxName);
  static Box<RecipeModel> get favorites => Hive.box<RecipeModel>(_favoriteBoxName);

  static Future<void> init() async {
    await Future.wait([
      Hive.openBox<dynamic>(_settingBoxName),
      Hive.openBox<RecipeModel>(_favoriteBoxName),
    ]);
  }

  static Future<List<int>> clear() => Future.wait([
        favorites.clear(),
        settings.clear(),
      ]);
}
