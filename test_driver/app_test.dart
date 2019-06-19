import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'app_test_key.dart';

main() {
  group("Application test", () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test("navigation bar behaviour", () async {
      await driver.waitFor(bottomKey);
      await driver.tap(dessertKey);
      await driver.tap(seafoodKey);
      await driver.tap(favoriteKey);
    });

    test("scroll dessert content behaviour", () async {
      await driver.tap(dessertKey);
      await driver.waitFor(dessertGrid, timeout: Duration(seconds: 5));
      await driver.scroll(dessertGrid, 0, 200, Duration(milliseconds: 500));
      await driver.scroll(dessertGrid, 0, -600, Duration(milliseconds: 500));
    });

    test("scroll seafood content behaviour", () async {
      await driver.tap(seafoodKey);
      await driver.waitFor(seafoodGrid, timeout: Duration(seconds: 5));
      await driver.scroll(seafoodGrid, 0, 200, Duration(milliseconds: 500));
      await driver.scroll(seafoodGrid, 0, -600, Duration(milliseconds: 500));
    });

    test("detail meals behaviour", () async {
      await driver.tap(dessertKey);
      await driver.waitFor(itemKey, timeout: Duration(seconds: 5));
      await driver.tap(itemKey);

      await driver.tap(find.text("See Detail"));

      await driver.waitFor(detailMealsStack, timeout: Duration(seconds: 10));
      await driver.waitFor(detailMealsList, timeout: Duration(seconds: 10));

      await driver.scroll(
          detailMealsList, 0, -1000, Duration(milliseconds: 500));
      await driver.scroll(
          detailMealsList, 0, 1000, Duration(milliseconds: 500));

      await driver.tap(detailMealsFab, timeout: Duration(seconds: 10));
      await driver.tap(detailMealsLeading);
    });

    test("search meals behaviour", () async {
      await driver.waitFor(searchMeals, timeout: Duration(seconds: 10));
      await driver.tap(searchMeals);

      await driver.waitFor(searchFields, timeout: Duration(seconds: 10));
      await driver.tap(searchFields);
      await driver.enterText("Apple");

      await driver.waitFor(itemKey);
      await driver.tap(itemKey);
      await driver.tap(find.text("See Detail"));

      await driver.waitFor(detailMealsStack, timeout: Duration(seconds: 10));
      await driver.waitFor(detailMealsList, timeout: Duration(seconds: 10));

      await driver.tap(detailMealsLeading);
      await driver.tap(searchLeading);
    });
  });
}