import 'package:flutter/material.dart';
import 'package:meals_catalogue/launcher/meals_config.dart';
import 'package:meals_catalogue/ui/meals_home.dart';

class MealsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = AppConfig.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: config.isDebug,
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.pinkAccent,
      ),
      home: MealsHome(),
    );
  }
}
