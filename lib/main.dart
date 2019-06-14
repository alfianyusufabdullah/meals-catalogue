import 'package:flutter/material.dart';
import 'package:meals_catalogue/ui/meals_home.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.pinkAccent,
      ),
      home: MealsHome(),
    ));
