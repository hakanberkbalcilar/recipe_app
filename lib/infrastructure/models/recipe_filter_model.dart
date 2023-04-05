import 'package:recipe_app/domain/entities/recipe_filter.dart';
import 'package:recipe_app/domain/enums/cuisines.dart';
import 'package:recipe_app/domain/enums/dietary.dart';

class RecipeFilterModel extends RecipeFilter {
  RecipeFilterModel({super.cuisine = Cuisines.none, super.dietary = Dietary.none, super.query = ''});
}
