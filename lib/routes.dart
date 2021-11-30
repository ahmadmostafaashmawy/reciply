import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciply/presentation/bloc/recipes/recipes_cubit.dart';
import 'package:reciply/presentation/screen/details_screen.dart';
import 'package:reciply/presentation/screen/home_screen.dart';
import 'data/repository/recipe_repository.dart';
import 'data/web_services/recipes_web_services.dart';
import 'domain/recipe_model.dart';
import 'presentation/screen/splash_screen.dart';

class AppRouter {
  static const splashScreen = '/';
  static const homeScreen = '/home';
  static const detailsScreen = '/detailsScreen';

  late RecipesRepository recipesRepository;
  late RecipesCubit recipesCubit;

  AppRouter() {
    recipesRepository = RecipesRepository(RecipesWebServices());
    recipesCubit = RecipesCubit(recipesRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => recipesCubit,
            child: const HomeScreen(),
          ),
        );

      case detailsScreen:
        final recipe = settings.arguments as RecipeModel;

        return MaterialPageRoute(
          builder: (_) => DetailsScreen(recipe),
        );
    }
  }
}
