import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/src/model/Producto.dart';
import 'package:supermarket/src/mywidgets/producto_row.dart';

class ProductoList extends StatelessWidget {
  CollectionReference productos =
      FirebaseFirestore.instance.collection('productos');
  CollectionReference categorias =
      FirebaseFirestore.instance.collection('categorias');
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: productos.snapshots(),
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
                return ProductoRow(Producto(
                    id: document.id,
                    nombre: document.data()['nombre'],
                    precio: document.data()['precio'],
                    cantidad: document.data()['cantidad'],
                    categoria: document.data()['categoria']));
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
