import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reciply/data/repository/recipe_repository.dart';
import 'package:reciply/domain/recipe_model.dart';

part 'recipes_state.dart';

class RecipesCubit extends Cubit<RecipesState> {
  final RecipesRepository recipeRepository;
  List<RecipeModel> recipes = [];

  RecipesCubit(this.recipeRepository) : super(RecipesInitial());

  Future<void> getRecipes() async {
    emit(RecipesLoading());
    try {
      recipeRepository.getRecipes().then((response) {
        if (response.isNotEmpty) {
          recipes = response;
          emit(RecipesSuccess(response));
        } else {
          emit(RecipesFailed("Error in getRecipes"));
        }
      });
    } catch (e) {
      print(e.toString());
      emit(RecipesFailed(e.toString()));
    }
  }
}
