import 'package:flutter/material.dart';

class PrevioCard extends StatefulWidget {
  PrevioCard(
      {Key key, this.nombre, this.estadoCheck})
      : super(key: key);

  final String nombre;
  final bool estadoCheck;

  @override
  _PrevioCardState createState() => _PrevioCardState();
}

class _PrevioCardState extends State<PrevioCard> {

  @override
  Widget build(BuildContext context) {
    return new Container(
        //height: 70,
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: new Stack(
          children: <Widget>[Container(
      //margin: new EdgeInsets.only(left: 20.0),
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
        constraints: new BoxConstraints(),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Container(height: 10),
            new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Checkbox(value: widget.estadoCheck,  onChanged: (value) {
                    setState(() {
                      //widget.estadoCheck=value;
                    });
                  },), 
                  Text(widget.nombre,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      
                  ButtonBar(
                    children: <Widget>[
                      
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
    )]))
    
    ;
  }

}