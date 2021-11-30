import 'dart:convert';
import 'package:reciply/domain/recipe_model.dart';

import '../web_services/recipes_web_services.dart';

class RecipesRepository {
  final RecipesWebServices recipeWebServices;

  RecipesRepository(this.recipeWebServices);

  Future<List<RecipeModel>> getRecipes() async {
    var response = await recipeWebServices.getRecipes();
    List jsonResponse = response.data;
    return jsonResponse
        .map((recipe) => RecipeModel.fromJson((recipe)))
        .toList();
  }
}
