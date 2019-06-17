import 'package:meals_catalogue/data/meals_data_mapper.dart';
import 'package:meals_catalogue/database/meals_database.dart';
import 'package:meals_catalogue/model/meals.dart';
import 'package:meals_catalogue/network/meals_network.dart';

Future<List<Meals>> loadMealsFromNetwork(String category) async {
  var result = await httpRequest("$ENDPOINT_FILTER$category");
  return generateMealList(result);
}

Future<Meals> loadMealsDetailFromNetwork(String id) async {
  var result = await httpRequest("$ENDPOINT_LOCKUP$id");
  return generateMeal(result);
}

Future<List<Meals>> searchMealFromNetwork(String name) async {
  var result = await httpRequest("$ENDPOINT_SEARCH$name");
  return generateMealList(result);
}

Future<List<Meals>> loadMealsFromLocal(
    DatabaseHelper helper, String category) async {
  return await helper.getMealFavorite(category);
}
