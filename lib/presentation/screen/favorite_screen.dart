import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reciply/constants/app_colors.dart';
import 'package:reciply/constants/localization_constains.dart';
import 'package:reciply/domain/recipe_model.dart';
import 'package:reciply/presentation/widgets/loading.dart';
import 'package:reciply/presentation/widgets/no_internet_widget.dart';
import 'package:reciply/presentation/widgets/text_display.dart';
import 'package:reciply/presentation/widgets/text_field_display.dart';
import 'package:reciply/utils/database_hepler.dart';

import '../../routes.dart';

class FavoriteScreen extends StatefulWidget {
  final DatabaseHelper db;

  const FavoriteScreen({Key? key, required this.db}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool _isSearching = false;
  final _searchTextController = TextEditingController();
  List<RecipeModel> recipesList = [];
  List<RecipeModel> searchedRecipes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColor.lightGrey,
        leading: const BackButton(color: AppColor.brown),
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildFutureWidget();
          } else {
            return const NoInternetWidget();
          }
        },
        child: LoadingWidget(),
      ),
    );
  }

  Widget buildFutureWidget() {
    return FutureBuilder<List<RecipeModel>>(
      future: widget.db.getAllRecipe(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        var data = snapshot.data;
        if (!snapshot.hasData || data == null) {
          return LoadingWidget();
        }
        recipesList = data;
        return buildRecipeList();
      },
    );
  }

  Widget _buildAppBarTitle() => Center(
        child: AppTextDisplay(
          translation: kFavorites,
          color: AppColor.brown,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildSearchField() => AppEditText(
        controller: _searchTextController,
        translation: kSearch,
        prefixIcon: const Icon(Icons.search),
        onChanged: (searchedRecipe) {
          addSearchedFOrItemsToSearchedList(searchedRecipe);
        },
      );

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        InkWell(
          onTap: () {
            _clearSearch();
            Navigator.pop(context);
          },
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(4)),
            child: Center(
                child: AppTextDisplay(
              translation: kCancel,
              color: AppColor.brown,
              fontSize: 14,
            )),
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(Icons.search, color: AppColor.brown),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  void addSearchedFOrItemsToSearchedList(String searchedRecipe) {
    searchedRecipes = recipesList
        .where(
            (recipe) => recipe.name!.toLowerCase().startsWith(searchedRecipe))
        .toList();
    setState(() {});
  }

  Widget buildRecipeList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _searchTextController.text.isEmpty
          ? recipesList.length
          : searchedRecipes.length,
      itemBuilder: (ctx, index) {
        return recipeItem(
          _searchTextController.text.isEmpty
              ? recipesList[index]
              : searchedRecipes[index],
        );
      },
    );
  }

  Widget recipeItem(RecipeModel recipe) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, AppRouter.detailsScreen,
          arguments: recipe),
      child: _searchTextController.text.isEmpty
          ? defaultRecipeItem(recipe)
          : searchedRecipeItem(recipe),
    );
  }

  Widget defaultRecipeItem(RecipeModel recipe) {
    return Stack(alignment: Alignment.bottomLeft, children: [
      cachedNetworkImage(recipe),
      Container(
        color: AppColor.white,
        padding: const EdgeInsets.all(16),
        child: AppTextDisplay(
          text: recipe.name,
          color: AppColor.black,
        ),
      ),
    ]);
  }

  Widget cachedNetworkImage(RecipeModel recipe) {
    if (recipe.image == null) {
      return const Icon(Icons.error);
    } else {
      return Hero(
        tag: recipe.id!,
        child: CachedNetworkImage(
          width: double.infinity,
          placeholder: (context, url) => LoadingWidget(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          imageUrl: recipe.image!,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  Widget searchedRecipeItem(RecipeModel recipe) {
    return SizedBox(
      height: ScreenUtil().setHeight(60),
      child: Row(
        children: [
          SizedBox(
              width: ScreenUtil().setWidth(60),
              child: cachedNetworkImage(recipe)),
          Expanded(child: AppTextDisplay(text: recipe.name))
        ],
      ),
    );
  }
}
