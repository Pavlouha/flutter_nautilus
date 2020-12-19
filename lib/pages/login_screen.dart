import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nautilus/logic/check_internet_connection.dart';
import 'package:flutter_nautilus/logic/logging_in.dart';
import 'package:flutter_nautilus/models/role.dart';
import 'package:flutter_nautilus/models/user.dart';
import 'package:flutter_nautilus/pages/primary_screen.dart';
import 'package:flutter_nautilus/widgets/alert_style.dart';
import 'package:flutter_nautilus/widgets/server_error_alert.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  var alertTitle = false;

  var noInternet = false;

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
                      if (noInternet) {
                        _onAlertWithNoInternet(context);
                      } else{
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
              key: Key('Username'),
              controller: loginController,
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Username',
              ),
            ),
            TextField(
              key: Key('Password'),
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
                  click();
                  Navigator.pop(context);
                  _onAlertWithCustomContentPressed(context);
                } else {
                      user = new User(value.token, value.userId, value.login, value.username,
                      value.password, Role(value.role.roleId, value.role.title), value.cell);
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) => PrimaryPage(user,0)),
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

  _onAlertWithNoInternet(context) {
    Alert(
      context: context,
      style: alertStyle(),
      type: AlertType.info,
      title: "No Internet!",
      desc: "Connect to network and open app again!",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => SystemNavigator.pop(),
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void click() {
    if (alertTitle == false) {
      setState(() {
        alertTitle = !alertTitle;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkConnection().then((internet) {
      if (!internet) {
        setState(() {
          noInternet = true;
        });
      }
    });
  }
}