

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:supermarket/src/pages/drawer_page.dart';
import 'package:supermarket/src/mywidgets/previo_Card.dart';
import 'package:supermarket/src/providers/productos_cloud.dart';

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
  }
  void pruebaColl(){
    setState(() {
      
    });
    print("usuario1: $_user");
  CollectionReference prod =
        FirebaseFirestore.instance.collection('usuarios');
        Query user = prod.where('email',isEqualTo: _user);
        user.snapshots().listen((data) {data.docs.map((e) => print(e['email']));});

}
  @override
  Widget build(BuildContext context) {
    CollectionReference prod =
        FirebaseFirestore.instance.collection('productosPrevios');
        pruebaColl();
    TextEditingController _textFieldController = TextEditingController();
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
                return PrevioCard(id: document.id ,nombre: document.data()['nombre'], estadoCheck: document.data()['check'],); 
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
                _displayDialog(context,_textFieldController);
              },
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

 _displayDialog(BuildContext context, TextEditingController controller) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Agregar a la lista previa'),
            shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
            content: Container(
              decoration: new BoxDecoration(
              //shape: BoxShape.circle,
              color: const Color(0xFFFFFF),
              borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
            ),
              child:TextField(
              controller: controller,
              decoration: InputDecoration(hintText: "Ingrese nombre del producto"),
            )),
            actions: <Widget>[
              RaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(width: 20, height: 0),
                  Text("Cancelar",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(width: 20, height: 0),
                ],
              ),
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
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
              color: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              onPressed: () {
                Map<String,dynamic> newPL= {
                  'nombre':controller.text,
                  'check':false,
                };
                ProductosCloud().addProductos(newProducto: newPL,collection: "productosPrevios");
                Navigator.pop(context);
              },
            ),
            ],
          );
        });
  }
}
