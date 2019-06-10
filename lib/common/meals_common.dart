import 'package:flutter/material.dart';

class RateWidget extends StatelessWidget {
  final int rate;

  RateWidget({Key key, this.rate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List<Widget>.generate(
          rate,
          (index) => Icon(
                Icons.favorite,
                color: Colors.pink,
                size: 15,
              )),
    );
  }
}

class CustomList extends StatelessWidget {
  final List<String> data;

  CustomList({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data.map((item) {
        return Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.arrow_right),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(item),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class TagsMeal extends StatelessWidget {
  final List<String> tags;

  const TagsMeal({Key key, this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: tags.map((item) {
        return Padding(
          padding: EdgeInsets.only(left: 3.0, right: 3.0),
          child: Chip(
            label: Text(
              item,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blue,
          ),
        );
      }).toList(),
    );
  }
}

class SliceText extends StatelessWidget {
  final String text;

  const SliceText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.length > 14 ? "${text.substring(0, 13)}..." : text,
      style: TextStyle(color: Colors.black, fontSize: 17),
    );
  }
}
