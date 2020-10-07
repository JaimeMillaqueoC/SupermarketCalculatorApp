import 'package:flutter/material.dart';
import 'package:supermarket/src/pages/drawer_page.dart';

class HistorialPage extends StatefulWidget {
  static final String route = "Historial_page";
  HistorialPage({Key key}) : super(key: key);

  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Historial"),
          backgroundColor: Color(0xFF736AB7),
          shadowColor: Color(0xFF736AB7),
        ),
        drawer: DrawerPage(),
        body: Center(child: Text("Soy el historial")));
  }
}
