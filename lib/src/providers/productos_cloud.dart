import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supermarket/src/model/Producto.dart';
import 'package:supermarket/src/mywidgets/previo_Card.dart';

class ProductosCloud {
  static final ProductosCloud _instancia = ProductosCloud._privado();
  ProductosCloud._privado();

  factory ProductosCloud() {
    return _instancia;
  }
  Future<void> addProductos({Map newProducto, String collection}) {
    CollectionReference users =
        FirebaseFirestore.instance.collection(collection);
    return users
        .add(newProducto)
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> restarProducto(Producto p) {
    CollectionReference productos =
        FirebaseFirestore.instance.collection('productos');

    if (p.cantidad <= 1) {
      return productos
          .doc(p.id)
          .update({'cantidad': p.cantidad})
          .then((value) => print("Producto actualizado"))
          .catchError((error) =>
              print("No se ha podido actualizar el usuario debido a $error"));
    }

    return productos
        .doc(p.id)
        .update({'cantidad': p.cantidad - 1})
        .then((value) => print("Producto actualizado"))
        .catchError((error) =>
            print("No se ha podido actualizar el usuario debido a $error"));
  }

  Future<void> sumarProducto(Producto p) {
    CollectionReference productos =
        FirebaseFirestore.instance.collection('productos');
    return productos
        .doc(p.id)
        .update({'cantidad': p.cantidad + 1})
        .then((value) => print("Producto actualizado"))
        .catchError((error) =>
            print("No se ha podido actualizar el usuario debido a $error"));
  }

  Future<void> eliminarProducto(Producto p) {
    CollectionReference productos =
        FirebaseFirestore.instance.collection('productos');
    return productos.doc(p.id).delete();
  }

  Future<void> eliminarProductoPrevio(PrevioCard pc) {
    CollectionReference productos =
        FirebaseFirestore.instance.collection('productosPrevios');
    return productos.doc(pc.id).delete();
  }

  Future<void> setCheck({String id, bool state}) {
    CollectionReference productos =
        FirebaseFirestore.instance.collection('productosPrevios');
    return productos
        .doc(id)
        .update({'check': state})
        .then((value) => print("Producto actualizado"))
        .catchError((error) =>
            print("No se ha podido actualizar el usuario debido a $error"));
  }
}
