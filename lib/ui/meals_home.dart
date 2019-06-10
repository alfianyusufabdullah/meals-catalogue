import 'package:flutter/material.dart';
import 'package:meals_catalogue/ui/meals_dessert.dart';
import 'package:meals_catalogue/ui/meals_seafood.dart';

class MealsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "Dessert"),
                Tab(text: "Seafood",),
              ],
            ),
            title: Text('Meals Catalogue'),
          ),
          body: TabBarView(
            children: [
              MealsDessert(),
              MealsSeafood()
            ],
          ),
        ),
      ),
    );
  }
}
