import 'package:meals_catalogue/model/meals.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class DatabaseHelper {
  static final _databaseName = "MealDatabase";
  static final _databaseVersion = 1;

  static final _mealTable = "meal_table";

  static final _colIdMeal = "col_id";
  static final _colCategoryMeal = "col_category";
  static final _colThumbMeal = "col_thumb";
  static final _colNameMeal = "col_name";

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
              $_colIdMeal INTEGER PRIMARY KEY,
              $_colCategoryMeal TEXT NON NULL,
              $_colNameMeal TEXT NON NULL,
              $_colThumbMeal TEXT NON NULL
            ) 
    ''');
  }

  Future<int> insertMeal(Map<String, dynamic> row) async {
    Database database = await instance.database;
    return await database.insert(_mealTable, row);
  }

  Future<List<Meals>> getMealFavorite(String category) async {
    Database database = await instance.database;
    dynamic data = await database.query(
      _mealTable,
      where: "",
    );
  }
}
