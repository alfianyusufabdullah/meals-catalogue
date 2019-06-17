import 'package:flutter/material.dart';
import 'package:meals_catalogue/data/meals_data.dart';
import 'package:meals_catalogue/model/meals.dart';
import 'package:meals_catalogue/ui/meals_item.dart';

class MealsSearch extends StatefulWidget {
  @override
  _MealsSearchState createState() => _MealsSearchState();
}

class _MealsSearchState extends State<MealsSearch> {
  List<Meals> _meals = [];
  double _elevation = 0;
  String _searchNotFound = "";

  ScrollController _scrollController = ScrollController();

  startSearch(String query) async {
    List<Meals> response = await searchMealFromNetwork(query);

    if (this.mounted) {
      setState(() {
        if (response != null && response.isEmpty) {
          _meals = [];
          _searchNotFound = "No result for \'$query\' ";
        } else {
          _meals = response;
        }
      });
    }
  }

  @override
  void initState() {
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
        headerSliverBuilder: (_, inner) {
          return [
            SliverAppBar(
              elevation: _elevation,
              backgroundColor: Color.fromARGB(220, 255, 255, 255),
              title: TextField(
                autofocus: true,
                style: TextStyle(fontSize: 17),
                decoration: InputDecoration.collapsed(
                  hintText: "Meals Name...",
                ),
                onChanged: startSearch,
              ),
              centerTitle: true,
              floating: true,
              pinned: true,
              snap: false,
            )
          ];
        },
        body: search(),
      ),
    );
  }

  Widget search() {
    if (_meals.length == 0) {
      return Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(_searchNotFound),
          ],
        ),
      );
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: _meals.length,
        itemBuilder: (context, position) =>
            MealItem(
                meals: _meals[position],
                position: position,
                category: "search"),
      );
    }
  }
}