import 'package:flutter/material.dart';
import 'package:meals_catalogue/common/meals_common.dart';
import 'package:meals_catalogue/model/meals.dart';
import 'package:meals_catalogue/ui/meals_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MealItem extends StatefulWidget {
  final Meals meals;
  final int position;
  final String category;

  const MealItem({Key key, this.meals, this.position, this.category})
      : super(key: key);

  @override
  _MealItemState createState() => _MealItemState();
}

class _MealItemState extends State<MealItem> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.position % 2 == 1
          ? EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 10)
          : EdgeInsets.only(left: 20, right: 5, top: 10, bottom: 10),
      child: FadeTransition(
        opacity: _animation,
        child: InkWell(
          onTap: () {
            final bar = SnackBar(
              content: Text("${widget.meals.name} selected!"),
              action: SnackBarAction(
                  label: "See Detail",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MealsDetail(
                                  id: widget.meals.id,
                                  mealThumbs: widget.meals.thumb,
                                  category: widget.category,
                                )));
                  }),
            );

            Scaffold.of(context).showSnackBar(bar);
          },
          borderRadius: BorderRadius.circular(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Hero(
                      tag: "${widget.meals.thumb}-${widget.category}",
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 100),
                        fadeOutDuration: Duration(milliseconds: 100),
                        placeholder: (_, args) => Image.asset(
                              "asset/blur_image.png",
                              fit: BoxFit.cover,
                            ),
                        imageUrl: widget.meals.thumb,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SliceText(
                text: widget.meals.name,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
