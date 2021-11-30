import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reciply/domain/recipe_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Recipe(id TEXT PRIMARY KEY, name TEXT, description TEXT, headline TEXT, country TEXT, image TEXT, carbos TEXT, proteins TEXT, calories TEXT, fats TEXT)");
  }

  Future<int> addFavRecipe(RecipeModel recipe) async {
    var dbClient = await db;
    RecipeModel myRecipe = RecipeModel(
      id: recipe.id,
      name: recipe.name,
      description: recipe.description,
      headline: recipe.headline,
      image: recipe.image,
      country: recipe.country,
      calories: recipe.calories,
      carbos: recipe.carbos,
      proteins: recipe.proteins,
      fats: recipe.fats,
    );
    int res = await dbClient.insert("Recipe", myRecipe.toJson());
    return res;
  }

  Future<List<RecipeModel>> getAllRecipe() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Recipe');
    List<RecipeModel> employees = [];
    for (int i = 0; i < list.length; i++) {
      var recipe = RecipeModel(
        id: list[i]["id"],
        name: list[i]["name"],
        description: list[i]["description"],
        headline: list[i]["headline"],
        image: list[i]["image"],
        country: list[i]["country"],
        calories: list[i]["calories"],
        carbos: list[i]["carbos"],
        proteins: list[i]["proteins"],
        fats: list[i]["fats"],
      );
      employees.add(recipe);
    }
    print(employees.length);
    return employees;
  }

  Future<int> removeFavRecipe(RecipeModel recipe) async {
    var dbClient = await db;

    int res = await dbClient
        .rawDelete('DELETE FROM Recipe WHERE id = ?', [recipe.id]);
    return res;
  }

  Future<bool> recipeExists(RecipeModel recipe) async {
    var dbClient = await db;

    var result = await dbClient.rawQuery(
      'SELECT EXISTS(SELECT 1 FROM Recipe WHERE id = ?)',
      [recipe.id],
    );
    int? exists = Sqflite.firstIntValue(result);
    return (exists == 1);
  }
}
