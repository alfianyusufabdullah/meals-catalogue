import 'package:http/http.dart' as http;
import 'package:meals_catalogue/data/meals_data_mapper.dart';
import 'package:meals_catalogue/database/meals_database.dart';
import 'package:meals_catalogue/model/meals.dart';

Future<List<Meals>> loadMealsFromNetwork(String category) async {
  return await http
      .get("https://www.themealdb.com/api/json/v1/1/filter.php?c=$category")
      .then((response) => generateResponse(response))
      .then((json) => generateList(json))
      .then((meals) => generateMealList(meals));
}

Future<Meals> loadMealsDetailFromNetwork(String id) async {
  return await http
      .get("https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id")
      .then((response) => generateResponse(response))
      .then((json) => generateList(json))
      .then((meals) => generateMeal(meals));
}

Future<Meals> searchMealFromNetwork(String name) async {
  return await http
      .get("https://www.themealdb.com/api/json/v1/1/search.php?s$name")
      .then((response) => generateResponse(response))
      .then((json) => generateList(json))
      .then((meals) => generateMeal(meals));
}

Future<List<Meals>> loadMealsFromLocal(DatabaseHelper helper,String category) async{
  return await helper.getMealFavorite(category);
}