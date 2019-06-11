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

class _MealsDetailState extends State<MealsDetail>
    with TickerProviderStateMixin {
  Meals _meals;
  bool _isFavorite = false;

  ScrollController _scrollController;
  AnimationController _animationController;
  Animation<double> _floatingAnimation;

  requestData() async {
    var meal = await loadMealsDetailFromNetwork(widget.id);
    setState(() {
      _meals = meal;
    });
  }

  @override
  void initState() {
    requestData();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 180));

    _floatingAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 1.0, curve: Curves.linear),
    );

    _scrollController = ScrollController(initialScrollOffset: 0.0);
    _scrollController.addListener(() {
      var offset = _scrollController.offset;
      setState(() {
        if (offset > 200) {
          _animationController.reverse();
        } else
          _animationController.forward();
      });
    });

    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Detail",
      home: Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
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
      return Stack(
        children: <Widget>[
          ListView(
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
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: ScaleTransition(
              scale: _floatingAnimation,
              alignment: FractionalOffset.center,
              child: FloatingActionButton(
                backgroundColor: Colors.pink,
                onPressed: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                },
                child: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
