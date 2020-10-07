import 'package:flutter/material.dart';
import 'package:supermarket/src/services/authentication_service.dart';
import 'package:provider/provider.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.shopping_basket,
              text: 'Pedido actual',
              onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.pushReplacementNamed(context, 'Home_page')
                  }),
          _createDrawerItem(
              icon: Icons.assignment,
              text: 'Lista previa',
              onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.pushReplacementNamed(context, 'ListaPrevia_page')
                  }),
          _createDrawerItem(
              icon: Icons.history,
              text: 'Historial de pedidos',
              onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.pushReplacementNamed(context, "Historial_page")
                  }),
          _createDrawerItem(
              icon: Icons.exit_to_app,
              text: 'LogOut',
              onTap: () => {
                    context.read<AuthenticationService>().signOut(),
                    Navigator.pushReplacementNamed(context, "Login_page")
                  }),
          ListTile(
            title: Text('0.0.1'),
            onTap: () {},
          )
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Color(0xFF736AB7),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("El Pedido App",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            )
          ],
        ));
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(padding: EdgeInsets.only(left: 8.0), child: Text(text))
        ],
      ),
      onTap: onTap,
    );
  }
}
