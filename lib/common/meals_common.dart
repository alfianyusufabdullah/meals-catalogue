import 'package:flutter/material.dart';

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
          padding: EdgeInsets.only(
            left: 5,
            right: 5,
            top: 5,
            bottom: 5,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent[200],
                    Colors.blueAccent[100],
                  ],
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                child: Text(
                  item,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
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
