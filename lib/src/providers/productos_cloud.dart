import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supermarket/src/mywidgets/producto_card.dart';
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
    // Call the user's CollectionReference to add a new user
    return users
        .add(newProducto)
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> restarProducto(ProductoCard pc) {
    CollectionReference productos =
        FirebaseFirestore.instance.collection('productos');

    if (pc.cantidad <= 1) {
      return productos
          .doc(pc.id)
          .update({'cantidad': pc.cantidad})
          .then((value) => print("Producto actualizado"))
          .catchError((error) =>
              print("No se ha podido actualizar el usuario debido a $error"));
    }

    return productos
        .doc(pc.id)
        .update({'cantidad': pc.cantidad - 1})
        .then((value) => print("Producto actualizado"))
        .catchError((error) =>
            print("No se ha podido actualizar el usuario debido a $error"));
  }

  Future<void> sumarProducto(ProductoCard pc) {
    CollectionReference productos =
        FirebaseFirestore.instance.collection('productos');
    return productos
        .doc(pc.id)
        .update({'cantidad': pc.cantidad + 1})
        .then((value) => print("Producto actualizado"))
        .catchError((error) =>
            print("No se ha podido actualizar el usuario debido a $error"));
  }

  Future<void> eliminarProducto(ProductoCard pc) {
    CollectionReference productos =
        FirebaseFirestore.instance.collection('productos');
    return productos.doc(pc.id).delete();
  }
  Future<void> eliminarProductoPrevio( PrevioCard pc) {
    CollectionReference productos =
        FirebaseFirestore.instance.collection('productosPrevios');
    return productos.doc(pc.id).delete();
  }
}
