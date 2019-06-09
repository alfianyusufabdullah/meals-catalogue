import 'package:flutter/material.dart';
import 'package:meals_catalogue/common/meals_common.dart';
import 'package:meals_catalogue/model/meals.dart';

class MealsDetail extends StatelessWidget {
  final Meals meals;
  final int position;

  MealsDetail({Key key, this.meals, this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Detail",
      home: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool inner) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 220,
                floating: false,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  background: Hero(
                    tag: '${meals.path}$position',
                    child: Image.asset(
                      meals.path,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ];
          },
          body: ListView(
            padding: EdgeInsets.all(20),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  meals.name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: RateWidget(rate: meals.rate),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(meals.desc),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text("Ingredient",
                    style: TextStyle(color: Colors.black, fontSize: 17)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: CustomList(
                  data: meals.ingredient,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text("Steps",
                    style: TextStyle(color: Colors.black, fontSize: 17)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: CustomList(
                  data: meals.steps,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
