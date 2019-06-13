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
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, inner) {
          return [
            SliverAppBar(
              elevation: _elevation,
              backgroundColor: Color.fromARGB(220, 255, 255, 255),
              title: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 5.0),
                    child: Image.asset("asset/shrimp.png"),
                  ),
                  Text("Seafood"),
                ],
              ),
              centerTitle: true,
              floating: true,
              pinned: true,
              snap: false,
            ),
          ];
        },
        body: home(),
      ),
    );
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
                MealItem(_meals[position], position, "seafood")),
      );
    }
  }
}
