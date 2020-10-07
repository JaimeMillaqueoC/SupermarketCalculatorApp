import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supermarket/src/model/Producto.dart';

class ProductosCloud {
  static final ProductosCloud _instancia = ProductosCloud._privado();
  ProductosCloud._privado();

  factory ProductosCloud() {
    return _instancia;
  }
  Future<void> addProductos(Map newProducto) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('productos');
    // Call the user's CollectionReference to add a new user
    return users
        .add(newProducto)
        .then((value) => print("User Added"))
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
}
