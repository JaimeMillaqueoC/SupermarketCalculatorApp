import 'package:flutter/material.dart';

class ProductoCard extends StatefulWidget {
  static String route = "/Producto";
  String nombreA;
  String categoriaA ;
  int cantidadA;
  int preciox1A;
  int precioTotalProductoA;
   ProductoCard({String nombreA, int cantidadA, int precioTotalProductoA, int preciox1A, String categoriaA}) {
    this.nombreA = nombreA;
    this.cantidadA = cantidadA;
    this.preciox1A =preciox1A;
    this.precioTotalProductoA=precioTotalProductoA;
    this.categoriaA =categoriaA;
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
  @override
  void initState(){
    _nombreA =widget.nombreA;
     _cantidadA = widget.cantidadA;
    _preciox1A = widget.preciox1A;
    _precioTotalProductoA = widget.precioTotalProductoA;
    _categoriaA=widget.categoriaA;
  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          onTap: () {
           
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  "$_nombreA X$_cantidadA     $_precioTotalProductoA",
                  style: TextStyle(fontSize: 22.0),
                ),
                subtitle: Text(
                  "Precio x1: $_preciox1A",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.expand_more),
                    color: Colors.blue,
                    tooltip: 'Decrecer en 1 la cantidad de producto',
                    onPressed: () {
                      _cantidadA--;
                      _precioTotalProductoA = _precioTotalProductoA-_preciox1A;
                      if (_cantidadA < 1) {
                        _cantidadA = 1;
                        _precioTotalProductoA=_preciox1A;
                      }
                      
                      //listaA.setState(() {print("press"); });
                      setState(() {});
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.expand_less),
                    color: Colors.blue,
                    tooltip: 'Aumentar en 1 la cantidad de producto',
                    onPressed: () {
                      
                      //listaA.setState(() { });
                      setState(() {
                      _cantidadA++;
                      _precioTotalProductoA = _preciox1A+_precioTotalProductoA;
                      print(_cantidadA);
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    tooltip: 'Borrar articulo',
                    onPressed: () {
                      //proLista.eliminarProducto(nombreA);
                      
                      //listaA.setState(() { });
                    },
                  ),
                ],
              ),
            ],
          )
        ),
    );
  }
}