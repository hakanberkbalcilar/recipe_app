import 'package:recipe_app/core/database/database.dart';
import 'package:recipe_app/core/enum/languages.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsProvider with ChangeNotifier {
  Box<dynamic> get _box => Database.settings;

  ThemeMode get themeMode => ThemeMode.values[_box.get("theme_mode", defaultValue: 0)];
  Languages get language => Languages.values[_box.get("language", defaultValue: 0)];

  Future<void> changeThemeMode(ThemeMode? value) => _update("theme_mode", value!.index);

  Future<void> changeLanguage(Languages? value) => _update("language", value!.index);

  Future<void> _update(String key, dynamic value) async {
    await _box.put(key, value);
    notifyListeners();
  }

  Future<int> clear() => _box.clear();
}
