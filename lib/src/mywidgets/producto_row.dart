import 'package:flutter/material.dart';
import 'package:supermarket/src/model/Producto.dart';
import 'package:supermarket/src/providers/productos_cloud.dart';

class ProductoRow extends StatelessWidget {
  /* Inicializamos un producto para la Fila */
  final Producto producto;
  ProductoRow(this.producto);

  @override
  Widget build(BuildContext context) {
    /* Calculamos el precio total al multiplicar precio unitario por cantidad */
    int _precioTotal = producto.precio * producto.cantidad;

    /* ALERTA */
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('¡Cuidado!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Estás a punto de eliminar para siempre un producto'),
                  Text('¿Quieres continuar?'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Eliminar'),
                onPressed: () {
                  Navigator.of(context).pop();
                  ProductosCloud().eliminarProducto(producto);
                },
              ),
            ],
          );
        },
      );
    }

    /* CÍRCULO DE CANTIDAD */
    final productoThumbnail = new Container(
        alignment: new FractionalOffset(0.0, 0.5),
        margin: const EdgeInsets.only(left: 2),
        child: CircleAvatar(
          child: Text(producto.cantidad.toString()),
        ));

    /* CARD DEL PRODUCTO */
    final productoCard = new Container(
      margin: new EdgeInsets.only(left: 20.0),
      decoration: new BoxDecoration(
          color: new Color(0xFF333366),
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0),
            )
          ]),
      child: new Container(
        constraints: new BoxConstraints.expand(),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Container(height: 10),
            new Text(
              producto.nombre,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("\$ " + _precioTotal.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Text("\$ " + producto.precio.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w300)),
                    ],
                  ),
                  ButtonBar(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.minimize),
                        color: Colors.blue,
                        tooltip: 'Decrecer en 1 la cantidad de producto',
                        onPressed: () {
                          ProductosCloud().restarProducto(producto);
                        },
                      ),
                      IconButton(
                          icon: Icon(Icons.add),
                          color: Colors.green,
                          tooltip: 'Aumentar en 1 la cantidad de producto',
                          onPressed: () {
                            ProductosCloud().sumarProducto(producto);
                          }),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        tooltip: 'Borrar articulo',
                        onPressed: () {
                          _showMyDialog();
                        },
                      ),
                    ],
                  ),
                ]),
          ],
        ),
      ),
    );

    /* RENDERIZADO DEL WIDGET */
    return new Container(
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: new Stack(
          children: <Widget>[
            productoCard,
            productoThumbnail,
          ],
        ));
  }
}
