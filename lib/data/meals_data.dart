import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:meals_catalogue/model/meals.dart';

Future<List<Meals>> loadFromLocalAsset(String asset) async {
  return await rootBundle
      .loadString(asset)
      .then((raw) => json.decode(raw))
      .then((meals) => meals["meals"] as List)
      .then((item) => generate(item));
}

List<Meals> generate(List data) {
  List<Meals> result = [];

  data.forEach((item) {
    List<String> ingredient = _generateIngredient(item);
    List<String> tags = _generateTags((item["strTags"] as String));
    List<String> steps = _generateSteps(item);
    steps.removeWhere((value) => value == null || value.isEmpty);

    var meal = Meals(
      (item["strMeal"] as String),
      (item["strMealThumb"] as String),
      tags,
      ingredient,
      steps,
    );

    result.add(meal);
  });

  return result;
}

List<String> _generateTags(String item) {
  List<String> tags = [];

  if (item != null && item.isNotEmpty) {
    List<String> check = item.split(",");
    check.forEach((er) => tags.add(er));
  }

  return tags;
}

List<String> _generateIngredient(dynamic items) {
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

List<String> _generateSteps(dynamic item) {
  return (item["strInstructions"] as String).split("\r\n");
}
