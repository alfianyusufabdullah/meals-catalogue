import 'package:flutter/material.dart';
import 'package:meals_catalogue/launcher/meals_app.dart';
import 'package:meals_catalogue/launcher/meals_config.dart';

void main() {
  var application = AppConfig(
    isDebug: false,
    child: MealsApp(),
  );

  runApp(application);
}