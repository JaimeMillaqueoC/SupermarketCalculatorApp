import 'package:flutter/material.dart';

class ProductoCard extends StatefulWidget {
  ProductoCard(
      {Key key, this.nombre, this.precio, this.cantidad, this.categoria})
      : super(key: key);

  final String nombre;
  final int precio;
  final int cantidad;
  final String categoria;

  @override
  _ProductoCardState createState() => _ProductoCardState();
}

class _ProductoCardState extends State<ProductoCard> {
  int precioTotal;

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: new Stack(
          children: <Widget>[
            productCard(),
            productThumbnail(),
          ],
        ));
  }

  productCard() {
    precioTotal = widget.cantidad * widget.precio;
    return Container(
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
              widget.nombre,
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
                      Text("\$ " + precioTotal.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Text("\$ " + widget.precio.toString(),
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
                        onPressed: () {},
                      ),
                      IconButton(
                          icon: Icon(Icons.add),
                          color: Colors.green,
                          tooltip: 'Aumentar en 1 la cantidad de producto',
                          onPressed: () {}),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        tooltip: 'Borrar articulo',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ]),
          ],
        ),
      ),
    );
  }

  productThumbnail() {
    return new Container(
        alignment: new FractionalOffset(0.0, 0.5),
        margin: const EdgeInsets.only(left: 2),
        child: CircleAvatar(
          child: Text(widget.cantidad.toString()),
        ));
  }
}
