import 'package:flutter/material.dart';

import 'package:supermarket/src/pages/home_page.dart';
import 'package:supermarket/src/providers/productos_firebase.dart';
import 'package:supermarket/src/providers/categoria_providers.dart';
import 'package:supermarket/src/utils/data.dart';

class FormularioPage extends StatefulWidget {
  static final route = "formulario";
  String nombreA;
  String categoriaA;
  int cantidadA;
  int preciox1A;
  String id;
  bool edit;
  FormularioPage(
      {String nombreA,
      int cantidadA,
      int preciox1A,
      String categoriaA,
      String id,
      bool edit: false}) {
    this.nombreA = nombreA;
    this.cantidadA = cantidadA;
    this.preciox1A = preciox1A;
    this.categoriaA = categoriaA;
    this.id = id;
    this.edit = edit;
  }
  @override
  _FormularioPageState createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  TextEditingController _nombreP = TextEditingController();
  TextEditingController _precioP = TextEditingController();
  TextEditingController _cantidadP = TextEditingController();
  Map<String, dynamic> nuevoProducto = {};
  String _selectedCategoria = "Frutas y verduras";
  String helperTextI = "";

  String _nombreA;
  int _cantidadA;
  int _preciox1A;
  String _categoriaA;
  String _id;
  bool _edit;
  @override
  void initState() {
    super.initState();
    _edit = widget.edit;
    if (widget.edit) {
      _nombreA = widget.nombreA;
      _cantidadA = widget.cantidadA;
      _preciox1A = widget.preciox1A;
      _categoriaA = widget.categoriaA;
      _id = widget.id;
      _loadDataSelectedCard();
    } else {
      _obtenerDatos(datos: ['nombreP', 'precioP', "categoriaP", "cantidadP"]);
    }
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
              image: DecorationImage(
                image: AssetImage("assets/img/carrito.png"),
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
                  _tituloPagina(),
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
                Text(
                  "Seleccione Categoria: ",
                  style: TextStyle(fontSize: 18.0),
                ),
                DropdownButton(
                  value: _selectedCategoria,
                  items: _listaCategorias(),
                  onChanged: onChangeDropdown,
                ),
              ],
            ),
          ),
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
              kType: TextInputType.number),
          Divider(),
          _crearInput(
              controller: _cantidadP,
              name: 'Cantidad producto',
              placeholder: 'Ingrese cuantos son',
              kType: TextInputType.number),
          Divider(),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.check),
            onPressed: () {
              if (_edit) {
                Map<String, dynamic> prodMap = {
                  "nombre": _nombreP.text,
                  "cantidad": int.parse(_cantidadP.text),
                  "precio": int.parse(_precioP.text),
                  "categoria": _selectedCategoria
                };
                ProductosFirebase().eliminarProducto(_categoriaA, _id).then((value) => ProductosFirebase().editarProducto(prodMap, _id).then((value) =>
                    Navigator.of(context).pushReplacement(
                        new MaterialPageRoute(builder: (BuildContext context) {
                      return new HomepageState().build(context);
                    }))));
                
              } else {
                _subirProducto().then((value) => Navigator.of(context).pushReplacement(
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return new HomepageState().build(context);
                })));
                
              }

              /* if (_validarCampos()) {
                buscarUsuario();
              }*/
            },
          ),
        ],
      ),
    );
  }

  String _tituloPagina() {
    if (_edit) {
      return "Edite el producto";
    } else {
      return "Agregue al carrito";
    }
  }

  onChangeDropdown(String selectedCategoria) {
    setState(() {
      _selectedCategoria = selectedCategoria;
    });
  }

  List<DropdownMenuItem<String>> _listaCategorias() {
    List<DropdownMenuItem<String>> items = List();
    List<String> catP = Categoriaproviders().categorias;
    catP.forEach((element) {
      items.add(DropdownMenuItem(
        value: element,
        child: Text(
          element,
          style: TextStyle(fontSize: 18.0, color: Colors.blue),
        ),
      ));
    });

    return items;
  }

  Widget _crearInput(
      {TextEditingController controller,
      String name,
      String placeholder,
      TextInputType kType}) {
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
            helperText: helperTextI,
            helperStyle: TextStyle(fontSize: 13.5, color: Colors.red)),
        onChanged: (value) => _guardarDatos(),
      ),
    );
  }

  Future<void> _loadDataSelectedCard() {
    _nombreP.text = _nombreA;
    _precioP.text = _preciox1A.toString();
    _cantidadP.text = _cantidadA.toString();
    _selectedCategoria = _categoriaA;
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

  Future<void> _subirProducto() async{
    nuevoProducto['nombre'] = _nombreP.text;
    nuevoProducto['precio'] = int.parse(_precioP.text);
    nuevoProducto['cantidad'] = int.parse(_cantidadP.text);
    nuevoProducto['categoria'] = _selectedCategoria;
    bool resp = await ProductosFirebase().agregarProductos(nuevoProducto, _selectedCategoria);
  }
}
