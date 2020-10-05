import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supermarket/src/pages/drawer_page.dart';
import 'package:supermarket/src/pages/home_page.dart';
import 'package:supermarket/src/pages/formulario_page.dart';
import 'package:supermarket/src/providers/productos_firebase.dart';
import 'package:supermarket/src/providers/categoria_providers.dart';
import 'package:supermarket/src/mywidgets/producto_card.dart';
import 'package:supermarket/src/services/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:supermarket/src/utils/data.dart';
class ListaPreviaPage extends StatefulWidget {
  static final route = "ListaPrevia_page";
  @override
  ListaPreviaPageState createState() => ListaPreviaPageState();
}

class ListaPreviaPageState extends State<ListaPreviaPage> {
  String _user;
  String _pass;
  @override
  void initState() {
    super.initState();
    _obtenerDatos(datos: ['user','pass']);
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference prod =
        FirebaseFirestore.instance.collection('productosPrevios');
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista Previa"),
      ),
      drawer: DrawerPage(),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: prod.snapshots(),
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
                print(document.data()['nombre']);
                return productCard(document.data()['nombre']); 
              }).toList(),
            );
          },
        ),
      ),
      bottomNavigationBar: new Container(
        height: 80.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: Colors.blue,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(width: 20, height: 0),
                  Text("AGREGAR",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(width: 20, height: 0),
                ],
              ),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FormularioPage(
                          edit: false,
                        )));
              },
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
    Future<void> _obtenerDatos({List<String> datos}) async {
    for (String productoDato in datos) {
      bool exist = await Data().checkData(productoDato);
      if (exist) {
        String datoObtenido = await Data().getData(productoDato);
        print(datoObtenido);
        if (productoDato == 'user') {
          _user= datoObtenido;
        }
        if (productoDato == 'pass') {
          _pass = datoObtenido;
        }
        setState(() { });
         }
      }
    }
  Widget productCard(String nombre) {
   
    return Card(
      elevation: 15.0,
      color: new Color(0xFF333366),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
          onTap: () {
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [ListTile(
        title: Text(
        nombre,
          style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold, color: Colors.white, ),
        ),
      ),]
          )),
    );
  }
}
