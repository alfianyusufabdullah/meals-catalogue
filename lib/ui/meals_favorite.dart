import 'package:flutter/material.dart';
import 'package:meals_catalogue/data/meals_data.dart';
import 'package:meals_catalogue/model/meals.dart';
import 'package:meals_catalogue/ui/meals_favorite_page.dart';
import 'package:meals_catalogue/ui/meals_item.dart';

class MealsFavorite extends StatefulWidget {
  @override
  _MealsFavoriteState createState() => _MealsFavoriteState();
}

class _MealsFavoriteState extends State<MealsFavorite> {
  List<Meals> _meals = [];
  double _elevation = 0;
  ScrollController _scrollController = ScrollController();

  requestData() async {
    List<Meals> response = await loadMealsFromNetwork("Seafood");
    if (this.mounted) {
      setState(() {
        _meals = response;
      });
    }
  }

  @override
  void initState() {
    requestData();
    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.offset > 50) {
          _elevation = 8.0;
        } else {
          _elevation = 0.0;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, inner) {
            return [
              SliverAppBar(
                bottom: TabBar(tabs: [
                  Tab(
                    text: "Dessert",
                  ),
                  Tab(
                    text: "Seafood",
                  )
                ]),
                elevation: _elevation,
                backgroundColor: Color.fromARGB(220, 255, 255, 255),
                title: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 5.0),
                      child: Image.asset("asset/hearts.png"),
                    ),
                    Text("Favorite"),
                  ],
                ),
                floating: true,
                pinned: true,
                snap: false,
              ),
            ];
          },
          body: TabBarView(children: [
            MealsFavoritePage(category: "dessert"),
            MealsFavoritePage(category: "seafood"),
          ]),
        ),
      ),
    );
  }
}
