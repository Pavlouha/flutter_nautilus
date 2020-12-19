import 'package:flutter/material.dart';
import 'package:flutter_nautilus/logic/guns.dart';

import 'package:flutter_nautilus/models/gun.dart';

import 'package:flutter_nautilus/models/user.dart';
import 'package:flutter_nautilus/pages/primary_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class GunsPage extends StatefulWidget {
  final User _user;
  GunsPage(this._user);

  _GunsPageState createState() => _GunsPageState(_user);
}

class _GunsPageState extends State<GunsPage> {
  final User _user;
  _GunsPageState(this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.indigo, elevation: 0,
          title: Text('Gun#/Code/Price', style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(icon: Icon(Icons.update), color: Colors.white, onPressed: () =>
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PrimaryPage(_user,0)),
                        (route) => false)),
          ],
        ),
        body: FutureBuilder<List<Gun>>(
          future: getGuns(_user.token), builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: Colors.indigo,
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return FlatButton(
                      onPressed: () => _onAlertWithSelectedGunPressed(context, snapshot.data[index]),
                      child: Row(
                        //  crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left:30, right: 30),
                            child: Text(snapshot.data[snapshot.data.length - 1 -  index].gunId.toString(),
                                style: TextStyle(fontSize: 18, color: Colors.white)),
                          ),
                          Text(snapshot.data[snapshot.data.length -1 - index].vendorCode,
                              style: TextStyle(fontSize: 18, color: Colors.white)),
                          Container(
                            padding: EdgeInsets.only(left:30),
                            child: Text(snapshot.data[snapshot.data.length -1 - index].price.toString(),
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
              color: Colors.indigo,
              child: Text("Server error"),
            );
          }
          return Container(
            color: Colors.indigo,
            child: CircularProgressIndicator(),
          );
        },
        )
    );
  }

  /// Alert Dialog with Gun
  _onAlertWithSelectedGunPressed(context, Gun specific) {
    Alert(
        context: context,
        title:'Gun #' + specific.gunId.toString(),
        content: Column(
          children: <Widget>[
            Text("Code : ${specific.vendorCode}"),
            Text("Price : ${specific.price}"),
          ],
        ),
        ).show();
  }


}