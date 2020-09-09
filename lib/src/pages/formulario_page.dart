import 'package:flutter/material.dart';

import 'package:supermarket/src/providers/productos_firebase.dart';
import 'package:supermarket/src/utils/data.dart';

class Formulario_Page extends StatefulWidget {
  static final route = "formulario";
  @override
  _Formulario_PageState createState() => _Formulario_PageState();
}

class _Formulario_PageState extends State<Formulario_Page> {
  TextEditingController _nombreP = TextEditingController();
  TextEditingController _precioP = TextEditingController();
  TextEditingController _cantidadP = TextEditingController();
  Map<String, dynamic> nuevoProducto = {};
  String _selectedCategoria = "Frutas y verduras";

  @override
  void initState() {
    super.initState();
    _obtenerDatos(datos: ['nombreP', 'precioP',"categoriaP","cantidadP"]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito'),
      ),
      body: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage("assets/img/carrito.png"),
                                  //fit: BoxFit.fill,
                  ),
            ),
            child: null,
          ),
          Divider(),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Agregue al carrito",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 40.0,
                      color: Colors.blue[600]),
                )
              ],
            ),
          ),
          Divider(),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Seleccione Categoria: ",
                    style: TextStyle(
                      fontSize: 18.0),
                ),
                DropdownButton(
            value: _selectedCategoria,
            items: _listaCategorias(),
            onChanged: onChangeDropdown
            ,),
              ],
            ),
          )
          ,
          Divider(),
          _crearInput(
            controller: _nombreP,
            name: 'Nombre producto',
            placeholder: 'Ingrese el nombre del producto',
          ),
          Divider(),
         _crearInput(
            controller: _precioP,
            name: 'Precio producto',
            placeholder: 'Ingrese el precio del producto',
            kType: TextInputType.number
          ),
          Divider(),
         _crearInput(
            controller: _cantidadP,
            name: 'Cantidad producto',
            placeholder: 'Ingrese cuantos son',
            kType: TextInputType.number
          ),
          Divider(),
          
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.check),
            onPressed: () {
              _subirProducto();
             /* if (_validarCampos()) {
                buscarUsuario();
              }*/
            },
          ),
        ],
      ),
    );
  }
  onChangeDropdown(String selectedCategoria){
    setState(() {
      _selectedCategoria = selectedCategoria;
    });
  }
  List<DropdownMenuItem<String>> _listaCategorias(){
    List<DropdownMenuItem<String>> items = List();
    items.add(
      DropdownMenuItem(
        value: "Frutas y verduras",
        child: Text("Frutas y verduras",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.blue),
        ),
      )
    );
    items.add(
      DropdownMenuItem(
        value: "Lacteos",
        child: Text("Lacteos",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.blue
                      ),
                      
                      ),
      )
    );
    return items;
  }
  Widget _crearInput(
      {TextEditingController controller, String name, String placeholder, TextInputType kType}) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: TextField(
        keyboardType: kType,
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: name,
            hintText: placeholder,
            suffixIcon: Icon(Icons.account_circle),
            icon: Icon(Icons.people),
            //helperText: helperTextU,
            helperStyle: TextStyle(fontSize: 13.5, color: Colors.red)),
        onChanged: (value) => _guardarDatos(),
      ),
    );
  }
  //Obtiene datos de shared preferences
  Future<void> _obtenerDatos({List<String> datos}) async {
    for (String productoDato in datos) {
      bool exist = await Data().checkData(productoDato);
      if (exist) {
        String datoObtenido = await Data().getData(productoDato);
        print(datoObtenido);
        if (productoDato == 'nombreP') {
          _nombreP.text = datoObtenido;
        } 
        if (productoDato == 'precioP') {
          _precioP.text = datoObtenido;
        }
        if (productoDato == 'categoriaP') {
          _selectedCategoria = datoObtenido;
        } 
        if (productoDato == 'cantidadP') {
          _cantidadP.text = datoObtenido;
        } 
      }
    }
    setState(() {});
  }
  //guarda datos en shared preferences
  void _guardarDatos() async {

      await Data().saveData('nombreP', _nombreP.text);
      await Data().saveData('precioP', _precioP.text);
      await Data().saveData('categoriaP', _selectedCategoria);
      await Data().saveData('cantidadP', _cantidadP.text);
     // print("N: $_nombreP--P: $_precioP--Ct: $_selectedCategoria--Cn: $_cantidadP");
      setState(() {});
  }
  
  void _subirProducto(){
    nuevoProducto['nombre']=_nombreP.text;
    nuevoProducto['precio']=_precioP.text;
    nuevoProducto['cantidad']=_cantidadP.text;
    nuevoProducto['categoria']=_selectedCategoria;
    ProductosFirebase().agregarProductos(nuevoProducto, _selectedCategoria);
  }
}
