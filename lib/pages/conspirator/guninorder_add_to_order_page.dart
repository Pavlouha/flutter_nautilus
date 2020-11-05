import 'package:flutter/material.dart';
import 'package:flutter_nautilus/models/gun.dart';
import 'package:flutter_nautilus/models/gun_in_order.dart';
import 'package:flutter_nautilus/models/user.dart';

import 'choose_customer_screen.dart';
import 'gun_add_screen.dart';

class GunAddToOrderPage extends StatefulWidget {
  final User _user;
  final String commentary;
  final List<GunInOrder> _guns;

  GunAddToOrderPage(this._user, this.commentary, this._guns);

  _GunAddToOrderPageState createState() => _GunAddToOrderPageState(_user, commentary, this._guns);
}

class _GunAddToOrderPageState extends State<GunAddToOrderPage> {
  final User _user;
  final String commentary;
  final List<GunInOrder> _guns;
  _GunAddToOrderPageState(this._user, this.commentary, this._guns);

  @override
  Widget build(BuildContext context) {
    if (_guns!=null && _guns.length != null && _guns.length != 0) {
      return Scaffold(
        appBar: AppBar(backgroundColor: Colors.blueGrey, elevation: 0,
          title: Text('Guns/#/Sum', style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(icon: Icon(Icons.arrow_forward_rounded), color: Colors.white,
                onPressed:() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CustomerChoosingPage(_user, _guns, commentary),
                      ));
                }
            )
          ],),
        body: Container(
          color: Colors.blueGrey,
          padding: EdgeInsets.only(top: 20),
          child: ListView.builder(
              itemCount: _guns.length,
              itemBuilder: (context, index) => this._gunListOnScreen(_guns[index].gun.vendorCode,
                  _guns[index].quantity, _guns[index].sum)),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => GunSelectPage(_user, commentary, _guns)),
            );
          },
          child: Icon(Icons.add),
        ),
      );
    } else {
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => GunSelectPage(_user, commentary, _guns)),
      );
    }
  }

  _gunListOnScreen(String gun, int quantity, int sum) {
        return Row(
            children: [
              Container(
                padding: EdgeInsets.only(left:8, right: 8),
                child: Text(gun,
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              Container(
                padding: EdgeInsets.only(right: 8),
                child: Text(quantity.toString(),
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              Container(
                padding: EdgeInsets.only(right: 8),
                child: Text(sum.toString(),
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          );
      }
}

