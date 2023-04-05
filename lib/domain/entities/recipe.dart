import 'package:hive_flutter/hive_flutter.dart';

typedef RecipeList = List<Recipe>;

abstract class Recipe {
  Recipe({
    required this.id,
    required this.label,
    required this.image,
    required this.source,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String label;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final String source;
}
