import 'package:flutter/material.dart';

import 'package:meals_catalogue/data/meals_data.dart';
import 'package:meals_catalogue/common/meals_key.dart';
import 'package:meals_catalogue/model/meals.dart';
import 'package:meals_catalogue/ui/meals_item.dart';
import 'package:meals_catalogue/ui/meals_search.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class MealsDessert extends StatefulWidget {
  @override
  _MealsDessertState createState() => _MealsDessertState();
}

class _MealsDessertState extends State<MealsDessert> {
  List<Meals> _meals = [];
  double _elevation = 0;
  String _failedText = "Dessert";

  ScrollController _scrollController = ScrollController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  Future requestData() async {
    List<Meals> response = await loadMealsFromNetwork("Dessert");

    if (this.mounted) {
      if (response != null && response.isEmpty) {
        _refreshController.refreshFailed();
        setState(() {
          _failedText = "Swipe down to refresh meals";
        });
      } else {
        setState(() {
          _meals = response;
        });
        _refreshController.refreshCompleted();
      }
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
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, inner) {
          return [
            SliverAppBar(
              titleSpacing: 0,
              actions: <Widget>[
                IconButton(
                  key: Key(KEY_MEALS_SEARCH),
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MealsSearch()));
                  },
                ),
              ],
              elevation: _elevation,
              backgroundColor: Color.fromARGB(220, 255, 255, 255),
              title: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Image.asset("asset/cake.png"),
                  ),
                  Text("Dessert"),
                ],
              ),
              centerTitle: true,
              floating: true,
              pinned: true,
              snap: false,
            ),
          ];
        },
        body: SmartRefresher(
          enablePullDown: true,
          controller: _refreshController,
          header: ClassicHeader(
            idleText: "Pull down to load meals",
            refreshingText: "Getting meals data",
            releaseText: "Load data when release",
            completeText: "Meals updated!",
            failedText: "Failed to load meals data",
            completeDuration: Duration(milliseconds: 1000),
          ),
          onRefresh: () {
            requestData();
          },
          child: dessert(),
        ),
      ),
    );
  }

  Widget dessert() {
    if (_meals.length == 0) {
      return Padding(
        padding: EdgeInsets.only(top: 120.0),
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
                _failedText,
                style: TextStyle(fontSize: 14),
              ),
            )
          ],
        ),
      );
    } else {
      return GridView.builder(
        key: Key(KEY_GRID_DESSERT),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: _meals.length,
        itemBuilder: (context, position) => MealItem(
            meals: _meals[position], position: position, category: "dessert"),
      );
    }
  }
}
