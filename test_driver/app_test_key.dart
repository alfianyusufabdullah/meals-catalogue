import 'package:flutter_driver/flutter_driver.dart';
import 'package:meals_catalogue/common/meals_key.dart';

final bottomKey = find.byValueKey(KEY_BOTTOM_NAVIGATION);
final dessertKey = find.byValueKey(KEY_BOTTOM_ITEM_DESSERT);
final seafoodKey = find.byValueKey(KEY_BOTTOM_ITEM_SEAFOOD);
final favoriteKey = find.byValueKey(KEY_BOTTOM_ITEM_FAVORITE);

final itemKey = find.byValueKey("meals-1-item");

final seafoodGrid = find.byValueKey(KEY_GRID_SEAFOOD);
final dessertGrid = find.byValueKey(KEY_GRID_DESSERT);

final searchMeals = find.byValueKey(KEY_MEALS_SEARCH);
final searchFields = find.byValueKey(KEY_SEARCH_FIELD);
final searchLeading = find.byValueKey(KEY_SEARCH_LEADING);

final detailMealsStack = find.byValueKey(KEY_DETAIL_MEAL_STACK);
final detailMealsList = find.byValueKey(KEY_DETAIL_MEAL_LIST);
final detailMealsFab = find.byValueKey(KEY_DETAIL_MEAL_FAB);
final detailMealsLeading = find.byValueKey(KEY_DETAIL_MEAL_LEADING);
