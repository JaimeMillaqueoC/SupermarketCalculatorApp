//import 'dart:html';

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:supermarket/src/pages/formulario_page.dart';
import 'package:supermarket/src/pages/drawer_page.dart';
import 'package:supermarket/src/providers/productos_firebase.dart';
import 'package:supermarket/src/providers/categoria_providers.dart';
import 'package:supermarket/src/mywidgets/producto_Card.dart';
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

  List<Widget> items(AsyncSnapshot snapshot){
    //pruebas filtrando por categoria
    FirebaseFirestore.instance
  .collection('productos')
  .where('categoria', isEqualTo: "Frutas y verduras")
  .get().then((value) {
    value.docs.forEach((element) {print(element['nombre']); });
  } );
  //Fin pruebas--------------------------------------------------------
  //cargar DB en cards
 
    return snapshot.data.documents.map<Widget>((document){
      int precioTotalProductoC = document['cantidad'] * document['precio'];
      return ProductoCard(
        nombreA: document['nombre'],
        cantidadA:  document['cantidad'],
        categoriaA:  document['categoria'],
        preciox1A:  document['precio'],
        precioTotalProductoA: precioTotalProductoC,
      );
    }).toList();
  }
  CollectionReference prod = FirebaseFirestore.instance.collection('productos');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Pedido actual"),
        backgroundColor: Colors.blue,
      ),
      drawer: DrawerPage(),
      body: Container(
        child:StreamBuilder(
          stream: prod.snapshots(),
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.active) {
              return ListView(
                children: items(snapshot),
              );
            }else{
              return Center(child: CircularProgressIndicator());
            }
          },
          ),
        
        ),
      
      /*FutureBuilder(
        future: ProductosFirebase().productos,
        builder: (BuildContext contexto, AsyncSnapshot respuesta) {
          if (respuesta.hasData) {
            return respuesta.data.isNotEmpty
                ? ListView(
                    padding: EdgeInsets.all(10.0),
                    children: _crearItem(context, respuesta.data),
                  )
                : Center(
                    child: Text("No hay productos en el carrito"),
                  );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),*/
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
                  Text("setstate",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(width: 20, height: 0),
                ],
              ),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              onPressed: () {
                setState(() {
                  
                });
              },
            ),
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
                Navigator.pushNamed(context, FormularioPage.route);
              },
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  List<Widget> _crearItem(
      BuildContext context, List<Map<String, dynamic>> productosP) {
    List<String> categorias = Categoriaproviders().categorias;
    List<Map<String, dynamic>> productosCat = [];
    List<Widget> _listaCard = [];
    List<String> categoriasEncontradas = [];
    productosP.forEach((element) {
      for (String cat in categorias) {
        if (_existCategoria(cat, element)) {
          productosCat.add(element[cat]);
          categoriasEncontradas.add(cat);
        }
      }
    });
    int index = 0;
    productosCat.forEach((element) {
      _listaCard.add(
        Container(
          color: Colors.green[500],
          child: ListTile(
            title: Text(
              "${categoriasEncontradas.elementAt(index++)}",
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "${element.length} productos",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      );
      element.forEach((key, value) {
        //SET CARD HERE!
        int precioTotalProductoC = value['cantidad'] * value['precio'];
        _carritoTotal += precioTotalProductoC;
        _listaCard.add(ProductoCard(
          nombreA: value['nombre'],
          cantidadA: value['cantidad'],
          preciox1A: value['precio'],
          precioTotalProductoA: precioTotalProductoC,
          categoriaA: value['categoria'],
          id: key,
        ));
      });
    });
    return _listaCard;
  }

  bool _existCategoria(String cat, Map<String, dynamic> element) {
    List<dynamic> aux = [];
    try {
      aux.add(element[cat]);
    } catch (e) {}
    if (aux[0] == null) {
      return false;
    } else {
      return true;
    }
  }
}
