import 'package:flutter/material.dart';
import 'package:flutter_nautilus/logic/captain/roles.dart';
import 'package:flutter_nautilus/logic/captain/users.dart';
import 'package:flutter_nautilus/models/role.dart';
import 'package:flutter_nautilus/models/user.dart';
import 'package:flutter_nautilus/models/user_without_token.dart';
import 'package:flutter_nautilus/pages/primary_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UsersPage extends StatefulWidget {
  final User _user;
  UsersPage(this._user);

  _UsersPageState createState() => _UsersPageState(_user);
}

class _UsersPageState extends State<UsersPage> {
  final User _user;
  _UsersPageState(this._user);

  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _cellController = TextEditingController();

  List<Role> _roles = List();

  String _mySelection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.brown, elevation: 0,
          title: Text('Name/Role/Login', style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(icon: Icon(Icons.update), color: Colors.white, onPressed: () =>
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PrimaryPage(_user,1)),
                        (route) => false)),
            IconButton(icon: Icon(Icons.add_circle), color: Colors.white,
                onPressed: () {
                  _onAlertWithUserInsertingPressed(context);
                },
            ),
          ],),
        body: FutureBuilder<List<UserWithoutToken>>(
          future: getUsers(_user.token), builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: Colors.brown,
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return FlatButton(
                      padding: EdgeInsets.all(8),
                      onPressed: () {
                        _onAlertWithSelectedUserPressed(context, snapshot.data[index]);
                      },
                      child: Row(
                        //  crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left:8, right: 8),
                            child: Text(snapshot.data[index].username,
                                style: TextStyle(fontSize: 18, color: Colors.white)),
                          ),
                          Text(snapshot.data[index].role.title, style: TextStyle(fontSize: 18, color: Colors.white)),
                          Container(
                            padding: EdgeInsets.only(left:8, right: 8),
                            child: Text(snapshot.data[index].login,
                                style: TextStyle(fontSize: 18, color: Colors.white)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Container(
              color: Colors.brown,
              child: Text("${snapshot.error}"),
            );
          }
          return Container(
            color: Colors.brown,
            child: CircularProgressIndicator(),
          );
        },
        )
    );
  }

  /// Alert Dialog with User
  _onAlertWithSelectedUserPressed(context, UserWithoutToken specific) {
    Alert(
        context: context,
        title: specific.username,
        content: Column(
          children: <Widget>[
            Text("Login : ${specific.login}"),
            Text("Password : ${specific.password}"),
            Text("Role : ${specific.role.title}"),
            Text("Cell : ${specific.cell}"),
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.red,
            onPressed:() {
              if (specific.role.roleId!=0) {
                deleteUser(_user.token, specific.userId).then((value) {
                  if (value = true) {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PrimaryPage(_user, 1)),
                            (route) => false);
                  } else {
                    debugPrint(value.toString());
                  }
                }
                );
              }
            },
            child: Text( 'Delete',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  /// Alert Dialog with User Inserting
  _onAlertWithUserInsertingPressed(context) {
    Alert(
        context: context,
        title: 'New User',
        content: Column(
          children: <Widget>[
            TextField(
              controller: _loginController,
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Login',
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Password',
              ),
            ),
            DropdownButton(items:
            _roles.map((role) {
              return DropdownMenuItem(
                child: Text(role.title),
                value: role.title,
              );
            }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _mySelection = newValue;
                    Navigator.pop(context);
                    _onAlertWithUserInsertingPressed(context);
                  });},
              value: _mySelection),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: _cellController,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Cell',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed:() {
              if (_cellController.text!='' && _loginController.text!='' && _passwordController.text!=''
              && _usernameController.text!='') {
                debugPrint(_mySelection);
                insertUser(_loginController.text, _passwordController.text,
                    _roles, _mySelection, _usernameController.text, _cellController.text, _user.token);
              }
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PrimaryPage(_user,1)),
                      (route) => false);
            },
            child: Text( 'Next',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]).show();
  }

  @override
  void initState() {
    super.initState();
    getRoles(_user.token).then((value) {
      setState(() {
        value.forEach((element) {
          _roles.add(element);
         // debugPrint(element.title);
        });
        _mySelection = _roles[0].title;
      });
    });
  }
}