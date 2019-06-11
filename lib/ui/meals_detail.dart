import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meals_catalogue/common/meals_common.dart';
import 'package:meals_catalogue/data/meals_data.dart';
import 'package:meals_catalogue/model/meals.dart';

class MealsDetail extends StatefulWidget {
  final String id;
  final String mealThumbs;

  const MealsDetail({Key key, this.id, this.mealThumbs}) : super(key: key);

  @override
  _MealsDetailState createState() => _MealsDetailState();
}

class _MealsDetailState extends State<MealsDetail> {
  Meals _meals;

  requestData() async {
    var meal = await loadMealsDetailFromNetwork(widget.id);
    setState(() {
      _meals = meal;
    });
  }

  @override
  void initState() {
    requestData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Detail",
      home: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool inner) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: 270,
                floating: false,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  background: Hero(
                    tag: widget.mealThumbs,
                    child: CachedNetworkImage(
                      imageUrl: widget.mealThumbs,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ];
          },
          body: detail(),
        ),
      ),
    );
  }

  Widget detail() {
    if (_meals != null) {
      return ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              _meals.name,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TagsMeal(tags: _meals.tags),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text("Ingredient",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: CustomList(
              data: _meals.ingredient,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Text("Steps",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: CustomList(
              data: _meals.steps,
            ),
          )
        ],
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
