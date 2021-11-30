part of 'recipes_cubit.dart';

@immutable
abstract class RecipesState {}

class RecipesInitial extends RecipesState {}

class RecipesLoading extends RecipesState {}

class RecipesSuccess extends RecipesState {
  final List<RecipeModel> recipes;

  RecipesSuccess(this.recipes);
}

class RecipesFailed extends RecipesState {
  final String error;

  RecipesFailed(this.error);
}
