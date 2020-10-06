import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:supermarket/src/pages/drawer_page.dart';
import 'package:supermarket/src/pages/formulario_page.dart';
import 'package:supermarket/src/mywidgets/previo_Card.dart';
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
                return PrevioCard(nombre: document.data()['nombre'], estadoCheck: true,); 
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

 
}
