import 'package:flutter/material.dart';
import 'package:meals_catalogue/common/meals_common.dart';
import 'package:meals_catalogue/model/meals.dart';
import 'package:meals_catalogue/ui/meals_detail.dart';

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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MealsDetail(
                        meals: meals,
                        position: position,
                      )));
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
                    tag: '${meals.path}$position',
                    child: Image.asset(
                      meals.path,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                meals.name,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: RateWidget(rate: meals.rate),
            ),
          ],
        ),
      ),
    );
  }
}
