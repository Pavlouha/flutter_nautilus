import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nautilus/models/role.dart';
import 'package:flutter_nautilus/models/user.dart';
import 'package:flutter_nautilus/pages/primary_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginPage extends StatelessWidget {
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
                  height: 150,
                  width: 150,
                  child: RaisedButton(
                    child: Text('Log in', style: TextStyle(fontSize: 20)),
                    onPressed: () => _onAlertWithCustomContentPressed(context),
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
        title: "Authorization",
        content: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Username',
              ),
            ),
            TextField(
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
            //TODO авторизация
            onPressed: () {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) => PrimaryPage(new User(0, 'captain', 'Pavel Kesler',
                      'qwerty', new Role(0, 'captain'), 'Captain room'))),
                      (route) => false);
            },
            child: Text(
              "Next",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}