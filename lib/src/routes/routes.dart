import 'package:supermarket/src/pages/formulario_page.dart';

import 'package:flutter/material.dart';
import 'package:supermarket/src/pages/historial_page.dart';
import 'package:supermarket/src/pages/home_page.dart';
import 'package:supermarket/src/pages/listaPrevia_page.dart';
import 'package:supermarket/src/pages/login_page.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    LoginPage.route: (context) => LoginPage(),
    FormularioPage.route: (context) => FormularioPage(),
    Homepage.route: (context) => Homepage(),
    ListaPreviaPage.route: (context) => ListaPreviaPage(),
    HistorialPage.route: (context) => HistorialPage(),
  };
}
