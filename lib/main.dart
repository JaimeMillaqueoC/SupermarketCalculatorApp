import 'package:flutter/material.dart';
import 'package:supermarket/src/pages/home_page.dart';
import 'package:supermarket/src/routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Homepage.route,
      routes: getRoutes(),
    );
  }
}
