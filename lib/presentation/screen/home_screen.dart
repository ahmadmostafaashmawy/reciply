import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reciply/constants/app_colors.dart';
import 'package:reciply/constants/app_images.dart';
import 'package:reciply/constants/localization_constains.dart';
import 'package:reciply/domain/recipe_model.dart';
import 'package:reciply/presentation/bloc/recipes/recipes_cubit.dart';
import 'package:reciply/presentation/widgets/loading.dart';
import 'package:reciply/presentation/widgets/no_internet_widget.dart';
import 'package:reciply/presentation/widgets/text_display.dart';
import 'package:reciply/presentation/widgets/text_field_display.dart';

import '../../routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  final _searchTextController = TextEditingController();
  List<RecipeModel> recipesList = [];
  List<RecipeModel> searchedRecipes = [];

  @override
  void initState() {
    BlocProvider.of<RecipesCubit>(context).getRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColor.lightGrey,
        leading:
            _isSearching ? const BackButton(color: AppColor.red) : Container(),
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
            return buildBlocWidget();
          } else {
            return const NoInternetWidget();
          }
        },
        child: LoadingWidget(),
      ),
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<RecipesCubit, RecipesState>(
      builder: (context, state) {
        if (state is RecipesSuccess) {
          recipesList = (state).recipes;
          return buildComicList();
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  Widget _buildAppBarTitle() => Center(
        child: AppTextDisplay(
          translation: kAppName,
          fontFamily: "Pacifico",
          color: AppColor.brown,
        ),
      );

  Widget _buildSearchField() => AppEditText(
        controller: _searchTextController,
        translation: kSearch,
        prefixIcon: const Icon(Icons.search),
        onChanged: (searchedComic) {
          addSearchedFOrItemsToSearchedList(searchedComic);
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
              color: AppColor.red,
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

  void addSearchedFOrItemsToSearchedList(String searchedComic) {
    searchedRecipes = recipesList
        .where((comic) => comic.name!.toLowerCase().startsWith(searchedComic))
        .toList();
    setState(() {});
  }

  Widget buildComicList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _searchTextController.text.isEmpty
          ? recipesList.length
          : searchedRecipes.length,
      itemBuilder: (ctx, index) {
        return comicItem(
          _searchTextController.text.isEmpty
              ? recipesList[index]
              : searchedRecipes[index],
        );
      },
    );
  }

  Widget comicItem(RecipeModel character) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, AppRouter.detailsScreen,
          arguments: character),
      child: _searchTextController.text.isEmpty
          ? defaultCharacterItem(character)
          : searchedCharacterItem(character),
    );
  }

  Widget defaultCharacterItem(RecipeModel character) {
    return Stack(alignment: Alignment.bottomLeft, children: [
      cachedNetworkImage(character),
      Container(
        color: AppColor.white,
        padding: const EdgeInsets.all(16),
        child: AppTextDisplay(
          text: character.name,
          color: AppColor.black,
        ),
      ),
    ]);
  }

  Widget cachedNetworkImage(RecipeModel character) {
    if (character.image == null) {
      return const Icon(Icons.error);
    } else {
      return Hero(
        tag: character.id!,
        child: CachedNetworkImage(
          width: double.infinity,
          placeholder: (context, url) => LoadingWidget(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          imageUrl: character.image!,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  Widget searchedCharacterItem(RecipeModel character) {
    return SizedBox(
      height: ScreenUtil().setHeight(60),
      child: Row(
        children: [
          SizedBox(
              width: ScreenUtil().setWidth(60),
              child: cachedNetworkImage(character)),
          Expanded(child: AppTextDisplay(text: character.name))
        ],
      ),
    );
  }
}
