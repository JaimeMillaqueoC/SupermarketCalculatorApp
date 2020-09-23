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
    productos.add(datos['categorias']);
    return productos;
  }

  Future<bool> agregarProductos(Map<String, dynamic> nuevoProducto, String categoria) async{
    final resupuesta = await http.post("https://supermarket-9ebe8.firebaseio.com/categorias/$categoria.json", body: json.encode(nuevoProducto));
  return true;
  }
  Future<bool> editarProducto (Map<String, dynamic> producto, String id)async{
    final resupuesta = await http.put("https://supermarket-9ebe8.firebaseio.com/categorias/${producto['categoria']}/$id.json", body: json.encode(producto));
  return true;
  }
  Future<bool> eliminarProducto (String categoria,String id)async{
    final resupuesta = await http.delete("https://supermarket-9ebe8.firebaseio.com/categorias/$categoria/$id.json");
  return true;
  }
  Future<bool> agregarProductosPrevios(Map<String, dynamic> nuevoProducto) async{
    final resupuesta = await http.post("https://supermarket-9ebe8.firebaseio.com/ListaPrevia.json", body: json.encode(nuevoProducto));
  return true;
  }
}