import 'package:flutter/material.dart';
import 'package:flutter_nautilus/logic/conspirator/guns_in_order.dart';

import 'package:flutter_nautilus/models/gun_in_order.dart';
import 'package:flutter_nautilus/models/user.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class GunInOrderPage extends StatefulWidget {
  final User _user;
  final int _id;
  GunInOrderPage(this._user, this._id);

  _GunInOrderPageState createState() => _GunInOrderPageState(_user, _id);
}

class _GunInOrderPageState extends State<GunInOrderPage> {
  final User _user;
  final int _id;
  _GunInOrderPageState(this._user, this._id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.indigo, elevation: 0,
          title: Text('#/Gun/Quantity', style: TextStyle(color: Colors.white)),),
        body: FutureBuilder<List<GunInOrder>>(
          future: getGunsInOrder(_user.token, _id), builder: (context, snapshot) {
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
                      onPressed: () => _onAlertWithSelectedGunInOrderPressed(context, snapshot.data[index]),
                      child: Row(
                        //  crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left:30, right: 30),
                            child: Text(snapshot.data[snapshot.data.length - 1 -  index].gunInOrderId.toString(),
                                style: TextStyle(fontSize: 18, color: Colors.white)),
                          ),
                          Text(snapshot.data[snapshot.data.length -1 - index].gun.vendorCode,
                              style: TextStyle(fontSize: 18, color: Colors.white)),
                          Container(
                            padding: EdgeInsets.only(left:30),
                            child: Text(snapshot.data[snapshot.data.length -1 - index].quantity.toString(),
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
            //  child: Text("${snapshot.error}"),
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

  /// Alert Dialog with GunInOrder
  _onAlertWithSelectedGunInOrderPressed(context, GunInOrder specific) {
    Alert(
        context: context,
        title:'Gun #' + specific.gunInOrderId.toString(),
        content: Column(
          children: <Widget>[
            Text("Code : ${specific.gun.vendorCode}"),
            Text("Price : ${specific.gun.price}"),
            Text("Quantity : ${specific.quantity}"),
            Text("Sum : ${specific.sum}"),
            Text("State : ${specific.gunState.title}"),
          ],
        ),).show();
  }

}