import 'dart:convert';

import 'package:http/http.dart' as http;

class ProductosFirebase{

  static final ProductosFirebase _instancia = ProductosFirebase._privado();
  ProductosFirebase._privado();
  
  factory ProductosFirebase(){
    return _instancia;
  }
  Future<List<Map<String, dynamic>>> get productos async{
    List<Map<String, dynamic>> productos =[];
 
    final resupuesta = await http.get("https://supermarket-9ebe8.firebaseio.com/.json");
    Map<String, dynamic> datos = jsonDecode(resupuesta.body);
    //print(datos['categorias']);
    productos.add(datos['categorias']);
    //print(productos);
    /*datos.forEach((indice, contenido) {
      contenido['id']=indice;
      productos.add(contenido);
     });*/
    return productos;
  }
  Future<bool> agregarProductos(Map<String, dynamic> nuevoProducto, String categoria) async{

    final resupuesta = await http.post("https://supermarket-9ebe8.firebaseio.com/categorias/$categoria.json", body: json.encode(nuevoProducto));
  return true;
  }
}