class RecipeModel {
  String? id;
  String? fats;
  String? name;
  String? time;
  String? image;
  List<String>? weeks;
  String? carbos;
  String? fibers;
  double? rating;
  String? country;
  int? ratings;
  String? calories;
  String? headline;
  List<String>? keywords;
  List<String>? products;
  String? proteins;
  int? favorites;
  int? difficulty;
  String? description;
  bool? highlighted;
  List<String>? ingredients;
  List<String>? deliverableIngredients;

  RecipeModel({
    this.id,
    this.fats,
    this.name,
    this.time,
    this.image,
    this.weeks,
    this.carbos,
    this.fibers,
    this.rating,
    this.country,
    this.ratings,
    this.calories,
    this.headline,
    this.keywords,
    this.products,
    this.proteins,
    this.favorites,
    this.difficulty,
    this.description,
    this.highlighted,
    this.ingredients,
    this.deliverableIngredients,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        id: json["id"],
        fats: json["fats"],
        name: json["name"],
        time: json["time"],
        image: json["image"],
        // weeks: List<String>.from(json["weeks"].map((x) => x)),
        carbos: json["carbos"],
        fibers: json["fibers"],
        rating:
            json["rating"] != null ? json["rating"].toDouble() : json["rating"],
        country: json["country"],
        ratings: json["ratings"],
        calories: json["calories"],
        headline: json["headline"],
        keywords: List<String>.from(json["keywords"].map((x) => x)),
        products: List<String>.from(json["products"].map((x) => x)),
        proteins: json["proteins"],
        favorites: json["favorites"],
        difficulty: json["difficulty"],
        description: json["description"],
        highlighted: json["highlighted"],
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
        deliverableIngredients:
            List<String>.from(json["deliverable_ingredients"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        if (fats != null) "fats": fats,
        if (name != null) "name": name,
        if (time != null) "time": time,
        if (image != null) "image": image,
        if (weeks != null) "weeks": List<String>.from(weeks!.map((x) => x)),
        if (carbos != null) "carbos": carbos,
        if (fibers != null) "fibers": fibers,
        if (rating != null) "rating": rating,
        if (country != null) "country": country,
        if (ratings != null) "ratings": ratings,
        if (calories != null) "calories": calories,
        if (headline != null) "headline": headline,
        if (keywords != null)
          "keywords": List<String>.from(keywords!.map((x) => x)),
        if (products != null)
          if (products != null)
            "products": List<String>.from(products!.map((x) => x)),
        if (proteins != null) "proteins": proteins,
        if (favorites != null) "favorites": favorites,
        if (difficulty != null) "difficulty": difficulty,
        if (description != null) "description": description,
        if (highlighted != null) "highlighted": highlighted,
        if (ingredients != null)
          "ingredients": List<dynamic>.from(ingredients!.map((x) => x)),
        if (deliverableIngredients != null)
          "deliverable_ingredients":
              List<dynamic>.from(deliverableIngredients!.map((x) => x)),
      };
}
