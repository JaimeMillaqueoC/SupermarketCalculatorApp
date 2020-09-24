import 'package:flutter/material.dart';
import 'package:supermarket/src/pages/login_page.dart';
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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoginPage.route,
      routes: getRoutes(),
    );
  }
}
