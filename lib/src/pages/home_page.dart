import 'package:flutter/material.dart';
import 'package:supermarket/src/pages/formulario_page.dart';
import 'package:supermarket/src/providers/productos_firebase.dart';
import 'package:supermarket/src/providers/categoria_providers.dart';
import 'package:supermarket/src/mywidgets/producto_Card.dart';

class Homepage extends StatefulWidget {
  static final route = "Home_page";
  @override
  HomepageState createState() => HomepageState();
}
class HomepageState extends State<Homepage> {
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
                 Navigator.pushNamed(context, FormularioPage.route);
                      
                },
                child: Icon(Icons.add_shopping_cart),
              ),
            ],
          ),floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
  }
  List<ProductoCard> _crearItem(BuildContext context, List<Map<String, dynamic>> productosP){
    List<String> categorias =Categoriaproviders().categorias;
    List<Map<String,dynamic>> productosCat =[];
    List<ProductoCard> _listaCard = [];
    productosP.forEach((element) {
      for(String cat in categorias){
        if(existCategoria(cat, element)){
          productosCat.add(element[cat]);
        }
      }
      });
      productosCat.forEach((element) {element.forEach((key, value) {
        //SET CARD HERE!
        int precioTotalProductoC = value['cantidad']*value['precio'];
        _listaCard.add(ProductoCard(nombreA: value['nombre'], cantidadA: value['cantidad'],preciox1A: value['precio'],precioTotalProductoA: precioTotalProductoC, categoriaA:  value['categoria'], id: key,));
        });});
      return _listaCard;
  }
  bool existCategoria(String cat, Map<String,dynamic> element){
    List<dynamic> aux=[];
    try{
          aux.add(element[cat]);
        }
        catch (e){
        }
    if(aux[0]==null){
      return false;
    }else{
      return true;
    }
    
  }

}