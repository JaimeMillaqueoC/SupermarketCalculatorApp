import 'package:flutter/material.dart';
import 'package:supermarket/src/pages/home_page.dart';
import 'package:supermarket/src/pages/formulario_page.dart';
import 'package:supermarket/src/providers/productos_firebase.dart';

class ProductoCard extends StatefulWidget {
  static String route = "/Producto";
  String nombreA;
  String categoriaA;
  int cantidadA;
  int preciox1A;
  int precioTotalProductoA;
  String id;
  ProductoCard(
      {String nombreA,
      int cantidadA,
      int precioTotalProductoA,
      int preciox1A,
      String categoriaA,
      String id}) {
    this.nombreA = nombreA;
    this.cantidadA = cantidadA;
    this.preciox1A = preciox1A;
    this.precioTotalProductoA = precioTotalProductoA;
    this.categoriaA = categoriaA;
    this.id = id;
  }
  /*Map toJson() => {
        "nombre":nombre,
        "cantidad": cantidad,
        "precio":preciox1 ,
        "precioTotal":precioTotalProducto
      };*/
  @override
  createState() => _ProductoCard();
}

class _ProductoCard extends State<ProductoCard> {
  String _nombreA;
  int _cantidadA;
  int _preciox1A;
  int _precioTotalProductoA;
  String _categoriaA;
  String _id;
  @override
  void initState() {
    _nombreA = widget.nombreA;
    _cantidadA = widget.cantidadA;
    _preciox1A = widget.preciox1A;
    _precioTotalProductoA = widget.precioTotalProductoA;
    _categoriaA = widget.categoriaA;
    _id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FormularioPage(
                      nombreA: _nombreA,
                      cantidadA: _cantidadA,
                      preciox1A: _preciox1A,
                      categoriaA: _categoriaA,
                      id: _id,
                      edit: true,
                    )));
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  "$_nombreA X$_cantidadA     $_precioTotalProductoA",
                  style: TextStyle(fontSize: 20.0),
                ),
                subtitle: Text(
                  "Precio x1: $_preciox1A",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.minimize),
                    color: Colors.blue,
                    tooltip: 'Decrecer en 1 la cantidad de producto',
                    onPressed: () {
                      _cantidadA--;
                      _precioTotalProductoA =
                          _precioTotalProductoA - _preciox1A;
                      if (_cantidadA < 1) {
                        _cantidadA = 1;
                        _precioTotalProductoA = _preciox1A;
                      } else {
                        Map<String, dynamic> prodMap = {
                          "nombre": _nombreA,
                          "cantidad": _cantidadA,
                          "precio": _preciox1A,
                          "categoria": _categoriaA
                        };
                        ProductosFirebase().editarProducto(prodMap, _id);
                      }
                      setState(() {});
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.green,
                    tooltip: 'Aumentar en 1 la cantidad de producto',
                    onPressed: () {
                      setState(() {
                        _cantidadA++;
                        _precioTotalProductoA =
                            _preciox1A + _precioTotalProductoA;

                        Map<String, dynamic> prodMap = {
                          "nombre": _nombreA,
                          "cantidad": _cantidadA,
                          "precio": _preciox1A,
                          "categoria": _categoriaA
                        };
                        ProductosFirebase().editarProducto(prodMap, _id);
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    tooltip: 'Borrar articulo',
                    onPressed: () {
                      ProductosFirebase()
                          .eliminarProducto(_categoriaA, _id)
                          .then((value) => Navigator.of(context)
                                  .pushReplacement(new MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return new HomepageState().build(context);
                              })));
                    },
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
