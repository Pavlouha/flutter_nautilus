import 'package:flutter/material.dart';
import 'package:flutter_nautilus/logic/guns.dart';

import 'package:flutter_nautilus/models/gun.dart';
import 'package:flutter_nautilus/models/gun_in_order.dart';
import 'package:flutter_nautilus/models/gun_state.dart';
import 'package:flutter_nautilus/models/user.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'guninorder_add_to_order_page.dart';

class GunSelectPage extends StatefulWidget {
  final User _user;
  final String commentary;
  final List<GunInOrder> _guns;

  GunSelectPage(this._user, this.commentary, this._guns);

  _GunSelectPageState createState() => _GunSelectPageState(_user, commentary, this._guns);
}

class _GunSelectPageState extends State<GunSelectPage> {
  final User _user;
  final String commentary;
  final List<GunInOrder> _guns;
  _GunSelectPageState(this._user, this.commentary, this._guns);

  final _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.indigo, elevation: 0,
          title: Text('Guns', style: TextStyle(color: Colors.white)),
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
                      onPressed: () => _onAlertWithGunInsertingPressed(context, snapshot.data[index]),
                      child: Row(
                        //  crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left:30, right: 30),
                            child: Text(snapshot.data[index].vendorCode,
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
              child: Text("${snapshot.error}"),
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

  /// Alert Dialog with Gun Inserting
  _onAlertWithGunInsertingPressed(context, Gun specific) {
    Alert(
        context: context,
        title: 'Add Gun',
        content: Column(
          children: <Widget>[
            Text(specific.vendorCode),
            Text(specific.price.toString()),
            TextField(
              keyboardType: TextInputType.number,
              controller: _quantityController,
              decoration: InputDecoration(
                icon: Icon(Icons.account_balance_wallet_sharp),
                labelText: 'Quantity',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed:() {
      if (_quantityController.text != '') {
        int sum;
        sum = int.parse(_quantityController.text) * specific.price;
        setState(() {
          _guns.add(GunInOrder(
              0, specific, int.parse(_quantityController.text), sum, 0,
              GunState(0, '')));
        });
        Navigator.pop(context);
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => GunAddToOrderPage(_user, commentary, _guns)),
        );
      }
    },
    child: Text( 'Add',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]).show();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }
}

