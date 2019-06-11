import 'package:flutter/material.dart';
import 'package:meals_catalogue/data/meals_data.dart';
import 'package:meals_catalogue/model/meals.dart';
import 'package:meals_catalogue/ui/meals_item.dart';

class MealsSeafood extends StatefulWidget {
  @override
  _MealsSeafoodState createState() => _MealsSeafoodState();
}

class _MealsSeafoodState extends State<MealsSeafood> {
  List<Meals> _meals = [];

  requestData() async {
    List<Meals> response = await loadMealsFromNetwork("Seafood");
    setState(() {
      _meals = response;
    });
  }

  @override
  void initState() {
    requestData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return home();
  }

  Widget home() {
    if (_meals.length == 0) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Container(
        child: GridView.builder(
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: _meals.length,
            itemBuilder: (context, position) =>
                MealItem(_meals[position], position)),
      );
    }
  }
}
