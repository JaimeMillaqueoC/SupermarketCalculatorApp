import 'package:flutter/material.dart';
import 'package:supermarket/src/pages/drawer_page.dart';
import 'package:supermarket/src/pages/home_page.dart';
import 'package:supermarket/src/pages/formulario_page.dart';
import 'package:supermarket/src/providers/productos_firebase.dart';
import 'package:supermarket/src/providers/categoria_providers.dart';

class ListaPreviaPage extends StatefulWidget {
  static final route = "ListaPrevia_page";
  @override
  ListaPreviaPageState createState() => ListaPreviaPageState();
}

class ListaPreviaPageState extends State<ListaPreviaPage> {
  @override
  void initState() {
    super.initState();
    //ProductosFirebase().productos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista Previa"),
      ),
      drawer: DrawerPage(),
      body: FutureBuilder(
        future: ProductosFirebase().productos,
        builder: (BuildContext contexto, AsyncSnapshot respuesta) {
          if (respuesta.hasData) {
            return respuesta.data.isNotEmpty
                ? ListView(
                    children: _crearItem(context, respuesta.data),
                  )
                : Center(
                    child: Text("No hay productos en el carrito"),
                  );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FormularioPage(
                        lista: true,
                      )));
            },
            child: Icon(Icons.add_shopping_cart),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  List<Widget> _crearItem(
      BuildContext context, List<Map<String, dynamic>> productosP) {
    List<String> categorias = Categoriaproviders().categorias;
    List<Map<String, dynamic>> productosCat = [];
    List<Widget> _listaCard = [];
    List<String> categoriasEncontradas = [];
    productosP.forEach((element) {
      for (String cat in categorias) {}
    });
    return _listaCard;
  }
}
