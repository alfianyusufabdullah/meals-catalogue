import 'package:meals_catalogue/model/meals.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class DatabaseHelper {
  static final _databaseName = "MealDatabase";
  static final _databaseVersion = 1;

  static final _mealTable = "meal_table";

  static final colIdMeal = "col_id";
  static final colCategoryMeal = "col_category";
  static final colThumbMeal = "col_thumb";
  static final colNameMeal = "col_name";

  DatabaseHelper._instance();

  static final DatabaseHelper instance = DatabaseHelper._instance();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documents = await getApplicationDocumentsDirectory();
    String path = join(documents.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
            CREATE TABLE $_mealTable ( 
              $colIdMeal TEXT PRIMARY KEY,
              $colCategoryMeal TEXT NON NULL,
              $colNameMeal TEXT NON NULL,
              $colThumbMeal TEXT NON NULL
            ) 
    ''');
  }

  Future<int> insertMeal(Map<String, dynamic> row) async {
    Database database = await instance.database;
    return await database.insert(_mealTable, row);
  }

  Future<int> deleteMeal(String id) async {
    Database database = await instance.database;
    return await database
        .delete(_mealTable, where: "$colIdMeal LIKE ?", whereArgs: [id]);
  }

  Future<bool> isFavorite(String id) async {
    Database database = await instance.database;

    List<Map<String, dynamic>> data = await database.query(
      _mealTable,
      where: "$colIdMeal LIKE ?",
      whereArgs: [id],
    );

    return data != null && data.isNotEmpty ? true : false;
  }

  Future<List<Meals>> getMealFavorite(String category) async {
    Database database = await instance.database;

    List<Map<String, dynamic>> data = await database.query(
      _mealTable,
      where: "$colCategoryMeal LIKE ?",
      whereArgs: [category],
    );

    List<Meals> result = [];

    data.forEach((meal) {
      Meals meals = Meals(
        meal[colIdMeal],
        meal[colNameMeal],
        meal[colThumbMeal],
      );

      result.add(meals);
    });

    return result;
  }
}
