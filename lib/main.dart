import 'package:recipe_app/core/database/database.dart';
import 'package:recipe_app/infrastructure/models/recipe_model.dart';
import 'package:recipe_app/presentation/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await _initHive();

  runApp(const ProviderScope(child: App()));
}

Future<void> _initHive() async {
  await Hive.initFlutter("recipe_app");
  Hive.registerAdapter(RecipeModelAdapter());
  await Database.init();
}
