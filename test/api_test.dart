import 'package:meals_catalogue/data/meals_data.dart';
import 'package:meals_catalogue/data/meals_data_mapper.dart';
import 'package:meals_catalogue/model/meals.dart';
import 'package:test_api/test_api.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;

class ApiTest extends Mock implements http.Client {}

main() {
  final client = ApiTest();

  group("Request Dessert test", () {
    test("should request complete", () async {
      when(
        client.get(
            "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"),
      ).thenAnswer(
        (_) async => http.Response(generateMealList([]).toString(), 200),
      );

      expect(await loadMealsFromNetwork("Dessert"), isA<List<Meals>>());
    });

    test("should request failed", () async {
      when(
        client.get(
            "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"),
      ).thenAnswer(
        (_) async => http.Response(generateMealList([]).toString(), 404),
      );

      expect(await loadMealsFromNetwork("Dessert"), isA<List<Meals>>());
    });
  });

  group("Request Seafood test", () {
    test("should request complete", () async {
      when(
        client.get(
            "https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood"),
      ).thenAnswer(
        (_) async => http.Response(generateMealList([]).toString(), 200),
      );

      expect(await loadMealsFromNetwork("Seafood"), isA<List<Meals>>());
    });

    test("should request failed", () async {
      when(
        client.get(
            "https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood"),
      ).thenAnswer(
        (_) async => http.Response(generateMealList([]).toString(), 404),
      );

      expect(await loadMealsFromNetwork("Seafood"), isA<List<Meals>>());
    });
  });

  group("Request detail meal test", () {
    test("should request complete", () async {
      when(
        client
            .get("https://www.themealdb.com/api/json/v1/1/lookup.php?i=52772"),
      ).thenAnswer(
        (_) async => http.Response(generateMeal([]).toString(), 200),
      );

      expect(await loadMealsDetailFromNetwork("52772"), isA<Meals>());
    });

    test("should request failed", () async {
      when(
        client
            .get("https://www.themealdb.com/api/json/v1/1/lookup.php?i=52772"),
      ).thenAnswer(
        (_) async => http.Response(generateMeal([]).toString(), 404),
      );

      expect(await loadMealsDetailFromNetwork("52772"), isA<Meals>());
    });
  });

  group("Request search meal test", () {
    test("should request complete", () async {
      when(
        client.get(
            "https://www.themealdb.com/api/json/v1/1/search.php?s=Arrabiata"),
      ).thenAnswer(
        (_) async => http.Response(generateMealList([]).toString(), 200),
      );

      expect(await loadMealsFromNetwork("Arrabiata"), isA<List<Meals>>());
    });

    test("should request failed", () async {
      when(
        client
            .get("https://www.themealdb.com/api/json/v1/1/search.php?s=Mantan"),
      ).thenAnswer(
        (_) async => http.Response(generateMealList([]).toString(), 404),
      );

      expect(await loadMealsFromNetwork("Mantan"), isA<List<Meals>>());
    });
  });
}
