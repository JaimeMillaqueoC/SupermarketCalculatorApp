//import 'dart:html';

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:supermarket/src/model/Producto.dart';
import 'package:supermarket/src/mywidgets/producto_row.dart';
import 'package:supermarket/src/pages/formulario_page.dart';
import 'package:supermarket/src/pages/drawer_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homepage extends StatefulWidget {
  static final route = "Home_page";
  @override
  HomepageState createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference productos =
        FirebaseFirestore.instance.collection('productos');
    CollectionReference categorias =
        FirebaseFirestore.instance.collection('categorias');
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Pedido actual"),
        backgroundColor: Colors.blue,
      ),
      drawer: DrawerPage(),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: categorias.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Algo ha salido mal"));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            /* return new ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (_, index) => ProductoRow(Producto(
                    id: snapshot.data.docs[index].id,
                    nombre: snapshot.data.docs[index].data()['nombre'],
                    precio: snapshot.data.docs[index].data()['precio'],
                    cantidad: snapshot.data.docs[index].data()['cantidad'],
                    categoria: snapshot.data.docs[index].data()['categoria']))); */

            return new ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (_, index) {
                  Query productosFiltrados = FirebaseFirestore.instance
                      .collection('productos')
                      .where('categoria',
                          isEqualTo: snapshot.data.docs[index].data()['valor']);
                  return Column(children: <Widget>[
                    Text(snapshot.data.docs[index].data()['valor']),
                    Container(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: productosFiltrados.snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Center(child: Text("Algo ha salido mal"));
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          return ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              return ProductoRow(Producto(
                                  id: snapshot.data.docs[index].id,
                                  nombre: snapshot.data.docs[index]
                                      .data()['nombre'],
                                  precio: snapshot.data.docs[index]
                                      .data()['precio'],
                                  cantidad: snapshot.data.docs[index]
                                      .data()['cantidad'],
                                  categoria: snapshot.data.docs[index]
                                      .data()['categoria']));
                            },
                          );
                        },
                      ),
                    )
                  ]);
                });
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
          child: StreamBuilder<QuerySnapshot>(
              stream: productos.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                int montoTotal = 0;

                if (snapshot.hasError) {
                  return Text("Algo ha salido mal");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                /* Sumar los precios */

                for (var doc in snapshot.data.docs) {
                  montoTotal += doc.data()['precio'] * doc.data()['cantidad'];
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.receipt, color: Colors.white),
                    Text("$montoTotal",
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
                );
              })),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
