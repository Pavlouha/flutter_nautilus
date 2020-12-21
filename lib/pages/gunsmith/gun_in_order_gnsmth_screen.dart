import 'package:flutter/material.dart';
import 'package:flutter_nautilus/logic/gunsmith/gun_states.dart';
import 'package:flutter_nautilus/logic/gunsmith/guns_in_order_gnsmth.dart';
import 'package:flutter_nautilus/models/gun_in_order.dart';
import 'package:flutter_nautilus/models/gun_state.dart';
import 'package:flutter_nautilus/models/user.dart';
import 'package:flutter_nautilus/widgets/server_error_alert.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../primary_screen.dart';

class GunInOrderGunsmithPage extends StatefulWidget {
  final User _user;
  GunInOrderGunsmithPage(this._user);

  _GunInOrderGunsmithPageState createState() => _GunInOrderGunsmithPageState(_user);
}

class _GunInOrderGunsmithPageState extends State<GunInOrderGunsmithPage> {
  final User _user;
  _GunInOrderGunsmithPageState(this._user);

  List<GunState> _gunStates = List();

  String _mySelection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.indigo, elevation: 0,
          actions: [
            IconButton(icon: Icon(Icons.update), color: Colors.white, onPressed: () =>
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PrimaryPage(_user,1)),
                        (route) => false)),
          ],
          title: Text('#/Gun/Quantity', style: TextStyle(color: Colors.white)),),
        body: FutureBuilder<List<GunInOrder>>(
          future: getAllGunsInOrder(_user.token), builder: (context, snapshot) {
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
                      onPressed: () => _onAlertWithSelectedGunInOrderPressed(context, snapshot.data[snapshot.data.length - 1 -  index]),
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
          DropdownButton(items:
          _gunStates.map((state) {
            return DropdownMenuItem(
              child: Text(state.title),
              value: state.title,
            );
          }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _mySelection = newValue;
                  Navigator.pop(context);
                  _onAlertWithSelectedGunInOrderPressed(context, specific);
                });},
              value: _mySelection),
        ],
      ),buttons: [
      DialogButton(
        onPressed:() {
            debugPrint(_mySelection);
            changeGunState(_user.token, specific.orderId, _gunStates, _mySelection).then((value) {
              if (value != null) {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PrimaryPage(_user,1)),
                        (route) => false);
              } else {
                serverError(context);
              }
            });

        },
        child: Text( 'New State',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ]).show();
  }

  @override
  void initState() {
    super.initState();
    getGunStates(_user.token).then((value) {
      setState(() {
        value.forEach((element) {
          _gunStates.add(element);
          // debugPrint(element.title);
        });
        _gunStates.removeAt(4);
        _gunStates.removeAt(3);
        _gunStates.removeAt(2);
        _mySelection = _gunStates[0].title;
      });
    });
  }

}