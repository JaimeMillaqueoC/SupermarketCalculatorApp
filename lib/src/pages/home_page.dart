//import 'dart:html';

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:supermarket/src/pages/formulario_page.dart';
import 'package:supermarket/src/pages/drawer_page.dart';
import 'package:supermarket/src/mywidgets/producto_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';

class Homepage extends StatefulWidget {
  static final route = "Home_page";
  @override
  HomepageState createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  int _carritoTotal = 0;
  @override
  void initState() {
    super.initState();
    //ProductosFirebase().productos;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference prod =
        FirebaseFirestore.instance.collection('productos');
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Pedido actual"),
        backgroundColor: Colors.blue,
      ),
      drawer: DrawerPage(),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: prod.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Algo ha salido mal"));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return new ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return ProductoCard(
                    nombre: document.data()['nombre'],
                    precio: document.data()['precio'],
                    cantidad: document.data()['cantidad'],
                    categoria: document.data()['categoria']);
              }).toList(),
            );
          },
        ),
      ),
      bottomNavigationBar: new Container(
        height: 80.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: Colors.blue,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.receipt, color: Colors.white),
            Text("$_carritoTotal",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            RaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(width: 20, height: 0),
                  Text("AGREGAR",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(width: 20, height: 0),
                ],
              ),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FormularioPage(
                          edit: false,
                          home: this,
                        )));
              },
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
