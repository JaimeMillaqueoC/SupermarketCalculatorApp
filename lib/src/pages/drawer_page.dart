import 'package:flutter/material.dart';
import 'package:supermarket/src/pages/listaPrevia_page.dart';
class DrawerPage extends StatelessWidget{

  @override 
  Widget build (BuildContext context){
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text("Menú",
              style: TextStyle(
                fontSize: 20.0,
                
              ),
            ),
          ),
          ListTile(
            title: Text("Lista previa"),
            leading: Icon(Icons.assignment),
            onTap: (){Navigator.pushNamed(context, ListaPreviaPage.route);},
          )
        ],
      )
      );
  }
}