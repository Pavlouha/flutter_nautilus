import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nautilus/logic/logging_in.dart';
import 'package:flutter_nautilus/models/role.dart';
import 'package:flutter_nautilus/models/user.dart';
import 'package:flutter_nautilus/pages/primary_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  var alertTitle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ), child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 250,
                  width: 250,
                  child: Image.asset('assets/submarine.png'),
                ),
                Container(
                  height: 150,
                  width: 150,
                  child: RaisedButton(
                    child: Text('Log in', style: TextStyle(fontSize: 20)),
                    onPressed: () {
                      if (ifLoginAndPassExist() == true) {
                       String login = getLoginSF();
                       String password = getPasswordSF();
                       User user;
                       authorization(login, password).then((value) {
                           user = new User(value.token, value.id, value.login, value.username,
                               value.password, Role(value.role.id, value.role.title), value.cell);
                           Navigator.pushAndRemoveUntil(context,
                               MaterialPageRoute(builder: (context) => PrimaryPage(user)),
                                   (route) => false);
                         }
                       );
                      } else {
                        _onAlertWithCustomContentPressed(context);
                      }
                    }
                  ),
                )
              ],
            ),
          ),
      ),
    ));
  }

// Alert Dialog with login
  _onAlertWithCustomContentPressed(context) {
    Alert(
        context: context,
        title: 'Authorization',
        content: Column(
          children: <Widget>[
            TextField(
              controller: loginController,
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Password',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              User user;
              authorization(loginController.text, passwordController.text).then((value) {
                if (value == null) {

                } else {
                      user = new User(value.token, value.id, value.login, value.username,
                      value.password, Role(value.role.id, value.role.title), value.cell);
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) => PrimaryPage(user)),
                              (route) => false);
                }
              });
            },
            child: Text(
              alertTitle ? 'Wrong login or pass' : 'Next',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void click() {
    setState(() {
      alertTitle = !alertTitle;
    });
  }
}