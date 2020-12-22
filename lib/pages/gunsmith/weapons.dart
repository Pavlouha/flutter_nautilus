import 'package:flutter/material.dart';
import 'package:flutter_nautilus/logic/guns.dart';
import 'package:flutter_nautilus/models/gun.dart';
import 'package:flutter_nautilus/models/user.dart';
import 'package:flutter_nautilus/pages/primary_screen.dart';
import 'package:flutter_nautilus/widgets/delete_error_alert.dart';
import 'package:flutter_nautilus/widgets/no_data_entered_alert.dart';
import 'package:flutter_nautilus/widgets/server_error_alert.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class WeaponsPage extends StatefulWidget {
  final User _user;
  WeaponsPage(this._user);

  _WeaponsPageState createState() => _WeaponsPageState(_user);
}

class _WeaponsPageState extends State<WeaponsPage> {
  final User _user;
  _WeaponsPageState(this._user);

  final _codeController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.teal, elevation: 0,
          title: Text('VendorCode/Price', style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(icon: Icon(Icons.update), color: Colors.white, onPressed: () =>
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PrimaryPage(_user,0)),
                        (route) => false)),
            IconButton(icon: Icon(Icons.add_circle), color: Colors.white,
              onPressed: () {
                _onAlertWithGunInsertingPressed(context);
              },
            ),
          ],),
        body: FutureBuilder<List<Gun>>(
          future: getGuns(_user.token), builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: Colors.teal,
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return FlatButton(
                      padding: EdgeInsets.all(8),
                      onPressed: () {
                        _onAlertWithSelectedGunPressed(context, snapshot.data[index]);
                      },
                      child: Row(
                        //  crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left:8, right: 8),
                            child: Text(snapshot.data[index].vendorCode,
                                style: TextStyle(fontSize: 18, color: Colors.white)),
                          ),
                          Text(snapshot.data[index].price.toString(), style: TextStyle(fontSize: 18, color: Colors.white)),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Container(
              color: Colors.teal,
              child: Text("Server error"),
            );
          }
          return Container(
            color: Colors.teal,
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
        title: 'Gun # ${specific.gunId}',
        content: Column(
          children: <Widget>[
            Text("Code : ${specific.vendorCode}"),
            Text("Price : ${specific.price}"),
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.red,
            onPressed:() {
              deleteGun(_user.token, specific.gunId).then((value) {
                  if (value == "true") {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PrimaryPage(_user, 0)),
                            (route) => false);
                  } else if (value=="false") {
                    deleteError(context);
                  } else {
                    debugPrint(value.toString());
                    serverError(context);
                  }
                }
                );
            },
            child: Text( 'Delete',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  /// Alert Dialog with Gun Inserting
  _onAlertWithGunInsertingPressed(context) {
    Alert(
        context: context,
        title: 'New Gun',
        content: Column(
          children: <Widget>[
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                icon: Icon(Icons.login),
                labelText: 'CodeName',
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _priceController,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Price',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed:() {
              if (_codeController.text!='' && _priceController.text!='') {
                insertGun(_user.token, _codeController.text, _priceController.text).then((value) {
                  if (value != null) {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PrimaryPage(_user,0)),
                            (route) => false);
                  } else {
                    serverError(context);
                  }
                });

              } else {
                noDataError(context);
              }
            },
            child: Text( 'Next',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]).show();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}