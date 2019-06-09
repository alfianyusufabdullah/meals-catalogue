import 'package:flutter/material.dart';
import 'package:meals_catalogue/data/meals_data.dart';
import 'package:meals_catalogue/model/meals.dart';
import 'package:meals_catalogue/ui/meals_item.dart';

class MealsList extends StatelessWidget {
  final List<Meals> mealsItem = mealsData;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Meals",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Meals Catalogue"),
        ),
        body: Container(
          child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: mealsItem.length,
              itemBuilder: (context, position) =>
                  MealItem(mealsItem[position], position)),
        ),
      ),
    );
  }
}
