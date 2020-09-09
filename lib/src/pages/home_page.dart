import 'package:flutter/material.dart';
import 'package:supermarket/src/providers/productos_firebase.dart';
import 'package:supermarket/src/providers/categoria_providers.dart';
import 'package:supermarket/src/mywidgets/producto_Card.dart';

class Home_page extends StatefulWidget {
  static final route = "Home_page";
  @override
  Home_pageState createState() => Home_pageState();
}
class Home_pageState extends State<Home_page> {
  int _carritoTotal=0;
  @override
  void initState() {
    super.initState();
    //ProductosFirebase().productos;
  }
  
  @override
  Widget build(BuildContext context) { 
    
    return Scaffold(
        
        appBar: AppBar(
          title: Text("Carrito"),
        ),
        body: FutureBuilder(
          future: ProductosFirebase().productos,
          builder: (BuildContext contexto, AsyncSnapshot respuesta){
            if(respuesta.hasData){
              return respuesta.data.isNotEmpty ? ListView(
                children: _crearItem(context,respuesta.data),
              ): Center(
                child: Text("No hay productos en el carrito"),
              );
            }else{
              return Center(
                child: CircularProgressIndicator()
              );
            }
          },

          ),
        floatingActionButton:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text (
                "Total: $_carritoTotal", 
                style:TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 30.0
                ),
                
                 
              ),
              FloatingActionButton(

                onPressed: ()  {
                 /*Navigator.pushNamed(context, Formulario.nombrePagina,
                      arguments: this);*/
                      
                },
                child: Icon(Icons.add_shopping_cart),
              ),
            ],
          ),floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
  }
  List<ProductoCard> _crearItem(BuildContext context, List<Map<String, dynamic>> productosP){
    List<String> categorias =Categoria_providers().categorias;
    List<Map<String,dynamic>> productosCat =[];
    List<ProductoCard> _listaCard = [];
    productosP.forEach((element) {
      for(String cat in categorias){
        productosCat.add(element[cat]);
      }
      });
      productosCat.forEach((element) {element.forEach((key, value) {
        //SET CARD HERE!
        int precioTotalProductoC = value['cantidad']*value['precio'];
        _listaCard.add(ProductoCard(nombreA: value['nombre'], cantidadA: value['cantidad'],preciox1A: value['precio'],precioTotalProductoA: precioTotalProductoC, categoriaA:  value['categoria']));
        });});
      return _listaCard;
  }


}