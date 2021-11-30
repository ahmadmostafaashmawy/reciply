import 'package:dio/dio.dart';

class RecipesWebServices {
  late Dio dio;
  final baseUrl = 'https://api.npoint.io/';

  RecipesWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 60 seconds,
      receiveTimeout: 20 * 1000,
    );

    dio = Dio(options);
  }

  Future<dynamic> getRecipes() async {
    try {
      Response response = await dio.get('43427003d33f1f6b51cc');
      print(response.data.toString());
      return response;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
