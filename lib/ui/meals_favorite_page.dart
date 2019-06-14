import 'package:flutter/material.dart';
import 'package:meals_catalogue/data/meals_data.dart';
import 'package:meals_catalogue/database/meals_database.dart';
import 'package:meals_catalogue/model/meals.dart';
import 'package:meals_catalogue/ui/meals_item.dart';

class MealsFavoritePage extends StatefulWidget {
  final String category;

  const MealsFavoritePage({Key key, this.category}) : super(key: key);

  @override
  _MealsFavoritePageState createState() => _MealsFavoritePageState();
}

class _MealsFavoritePageState extends State<MealsFavoritePage> with WidgetsBindingObserver{
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<Meals> _meals = [];

  loadData() async {
    List<Meals> result =
        await loadMealsFromLocal(_databaseHelper, widget.category);
    if (this.mounted) {
      setState(() {
        _meals = result;
      });
    }
  }

  @override
  void initState() {
    loadData();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<bool> didPopRoute() {
    loadData();
    return super.didPopRoute();
  }

  @override
  Widget build(BuildContext context) {
    return home();
  }

  Widget home() {
    if (_meals.length == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "asset/plate.png",
              height: 120,
              width: 120,
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Daftar favorite kosong",
                style: TextStyle(fontSize: 17),
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: _meals.length,
            itemBuilder: (context, position) =>
                MealItem(_meals[position], position, "favorite-${widget.category}")),
      );
    }
  }
}
