import 'package:flutter/material.dart';
import 'package:supermarket/src/pages/formulario_page.dart';
import 'package:supermarket/src/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Map<String, WidgetBuilder> routes = <String, WidgetBuilder> {
    //Login.route: (context)=> Login(),
    FormularioPage.route: (context)=> FormularioPage(),
    Homepage.route: (context)=> Homepage(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Homepage.route,
     routes: routes,
    );
  }
}


