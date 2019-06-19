import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meals_catalogue/ui/meals_dessert.dart';
import 'package:meals_catalogue/ui/meals_favorite.dart';
import 'package:meals_catalogue/ui/meals_seafood.dart';
import 'package:meals_catalogue/common/meals_key.dart';

class MealsHome extends StatefulWidget {
  @override
  _MealsHomeState createState() => _MealsHomeState();
}

class _MealsHomeState extends State<MealsHome> {
  int _currentIndex = 0;
  List<BottomNavigationBarItem> bottomNavigationItem = [
    BottomNavigationBarItem(
      icon: Padding(
        key: Key(KEY_BOTTOM_ITEM_DESSERT),
        padding: EdgeInsets.all(5.0),
        child: Image.asset("asset/cake.png"),
      ),
      title: Text("Dessert"),
    ),
    BottomNavigationBarItem(
      icon: Padding(
        key: Key(KEY_BOTTOM_ITEM_SEAFOOD),
        padding: EdgeInsets.all(5.0),
        child: Image.asset("asset/shrimp.png"),
      ),
      title: Text("Seafood"),
    ),
    BottomNavigationBarItem(
      icon: Padding(
        key: Key(KEY_BOTTOM_ITEM_FAVORITE),
        padding: EdgeInsets.all(5.0),
        child: Image.asset("asset/hearts.png"),
      ),
      title: Text("Favorite"),
    ),
  ];

  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget pageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: pageChanged,
      children: <Widget>[
        MealsDessert(),
        MealsSeafood(),
        MealsFavorite(),
      ],
    );
  }

  void pageChanged(int position) {
    setState(() {
      _currentIndex = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return Scaffold(
      body: pageView(),
      bottomNavigationBar: BottomNavigationBar(
        key: Key(KEY_BOTTOM_NAVIGATION),
        type: BottomNavigationBarType.shifting,
        onTap: (position) {
          pageChanged(position);
          _pageController.animateToPage(position,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        },
        elevation: 15.0,
        selectedItemColor: Colors.pinkAccent,
        currentIndex: _currentIndex,
        items: bottomNavigationItem,
      ),
    );
  }
}
