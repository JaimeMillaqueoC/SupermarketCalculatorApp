import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supermarket/src/services/authentication_service.dart';

class LoginPage extends StatelessWidget {
  static String route = "Login_page";
/*   const LoginPage({Key key}) : super(key: key); */

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            child: SingleChildScrollView(
          child: Column(children: <Widget>[
            createHeader(),
            createForm(context),
          ]),
        )));
  }

  Widget createForm(context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          createFormTitle(),
          Divider(),
          createInputContainer(),
          createButtonsContainer(context),
        ],
      ),
    );
  }

  Widget createInput(String hint, Icon icon, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[100]))),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: icon,
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400])),
      ),
    );
  }

  Widget createSubmitButton(BuildContext context) {
    return Container(
      height: 50.0,
      child: RaisedButton(
        onPressed: () {
          context.read<AuthenticationService>().signIn(
              email: emailController.text, password: passwordController.text);
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              "Iniciar sesión",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget createRegisterButton() {
    return Container(
      height: 50.0,
      child: FlatButton(
          onPressed: () {},
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.0),
              side: BorderSide(color: Colors.grey[300])),
          padding: EdgeInsets.all(0),
          child: Container(
            constraints: BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text("No tengo una cuenta"),
          )),
    );
  }

  Widget createButtonsContainer(context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          createSubmitButton(context),
          Container(height: 10),
          createRegisterButton(),
        ],
      ),
    );
  }

  Widget createHeader() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/img/bglogin.png'), fit: BoxFit.fill)),
      child: Stack(
        children: <Widget>[
          Positioned(
              top: 100,
              left: 100,
              child: Container(
                child: Center(
                    child: Container(
                  height: 200,
                  width: 200,
                  child: Image.asset('assets/img/breakfast-colour-1200px.png'),
                )),
              ))
        ],
      ),
    );
  }

  Widget createFormTitle() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        "Inicio de sesión",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget createInputContainer() {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(143, 148, 251, .2),
                blurRadius: 20.0,
                offset: Offset(0, 10))
          ]),
      child: Column(
        children: <Widget>[
          createInput("Correo electrónico", Icon(Icons.email), emailController),
          createInput("Contraseña", Icon(Icons.lock), passwordController)
        ],
      ),
    );
  }
}
