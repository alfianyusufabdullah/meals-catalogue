import 'package:flutter/material.dart';
import 'package:meals_catalogue/common/meals_common.dart';
import 'package:meals_catalogue/model/meals.dart';
import 'package:meals_catalogue/ui/meals_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MealItem extends StatelessWidget {
  final Meals meals;
  final int position;

  MealItem(this.meals, this.position);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: position % 2 == 1
          ? EdgeInsets.only(left: 10, right: 20, top: 20)
          : EdgeInsets.only(left: 20, right: 10, top: 20),
      child: InkWell(
        onTap: () {
          final bar = SnackBar(
            content: Text("${meals.name} selected!"),
            action: SnackBarAction(
                label: "See Detail",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MealsDetail(
                                meals: meals,
                                position: position,
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
                    tag: '${meals.thumb}$position',
                    child: CachedNetworkImage(
                      placeholder: Image.asset(
                        "asset/blur_image.png",
                        fit: BoxFit.cover,
                      ),
                      imageUrl: meals.thumb,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: SliceText(
                text: meals.name,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
