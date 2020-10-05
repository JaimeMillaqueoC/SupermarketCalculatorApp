import 'package:cloud_firestore/cloud_firestore.dart';

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
}
