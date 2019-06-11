import 'dart:convert';

import 'package:meals_catalogue/model/meals.dart';
import 'package:http/http.dart' as http;

dynamic generateResponse(http.Response response) {
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return "";
  }
}

dynamic generateList(dynamic json) {
  if (json.isNotEmpty) {
    return json["meals"] as List;
  } else {
    return [];
  }
}

List<Meals> generateMealList(List<dynamic> data) {
  List<Meals> result = [];

  data.forEach((item) {
    var meal = Meals(
      item["idMeal"] as String,
      item["strMeal"] as String,
      item["strMealThumb"] as String,
    );

    result.add(meal);
  });

  return result;
}

Meals generate(List<dynamic> data) {

  dynamic item = data.first;

  List<String> ingredient = generateIngredient(item);
  List<String> tags = generateTags((item["strTags"] as String));
  List<String> steps = generateSteps(item);
  steps.removeWhere((value) => value == null || value.isEmpty);

  return Meals(
    (item["idMeal"] as String),
    (item["strMeal"] as String),
    (item["strMealThumb"] as String),
    tags: tags,
    ingredient: ingredient,
    steps: steps,
  );
}

List<String> generateTags(String item) {
  List<String> tags = [];

  if (item != null && item.isNotEmpty) {
    List<String> check = item.split(",");
    check.forEach((er) => tags.add(er));
  }

  return tags;
}

List<String> generateIngredient(dynamic items) {
  List<String> result = [];

  for (var position = 1; position <= 20; position++) {
    String ingredient = items["strIngredient$position"];
    String measure = items["strMeasure$position"];

    if (ingredient == null ||
        ingredient.isEmpty && measure == null ||
        measure.isEmpty) continue;

    result.add("$measure $ingredient");
  }

  return result;
}

List<String> generateSteps(dynamic item) {
  return (item["strInstructions"] as String).split("\r\n");
}
