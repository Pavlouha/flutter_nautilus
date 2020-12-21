import 'package:flutter/material.dart';

import 'package:flutter_nautilus/logic/conspirator/order_state.dart';
import 'package:flutter_nautilus/logic/orders.dart';
import 'package:flutter_nautilus/models/gun_in_order.dart';
import 'package:flutter_nautilus/models/order.dart';
import 'package:flutter_nautilus/models/order_state.dart';
import 'package:flutter_nautilus/models/user.dart';
import 'package:flutter_nautilus/pages/captain/guns_in_order_screen.dart';
import 'package:flutter_nautilus/pages/primary_screen.dart';
import 'package:flutter_nautilus/widgets/no_data_entered_alert.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'gun_add_screen.dart';

class OrdersConspiratorPage extends StatefulWidget {
  final User _user;
  OrdersConspiratorPage(this._user);

  _OrdersConspiratorPageState createState() => _OrdersConspiratorPageState(_user);
}

class _OrdersConspiratorPageState extends State<OrdersConspiratorPage> {
  final User _user;
  _OrdersConspiratorPageState(this._user);

  final _commentController = TextEditingController();

  List<OrderState> _states = List();

  List<GunInOrder> gunList = [];

  String _mySelection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.indigo, elevation: 0,
          title: Text('Order#/Client/State', style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(icon: Icon(Icons.update), color: Colors.white, onPressed: () =>
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PrimaryPage(_user,0)),
                        (route) => false)),
            IconButton(icon: Icon(Icons.add_circle), color: Colors.white, onPressed: () {
              _onAlertWithOrderInsertingPressed(context);
            }),
          ],
        ),
        body: FutureBuilder<List<Order>>(
          future: getNotCancelledOrders(_user.token), builder: (context, snapshot) {
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
                      onPressed: () => _onAlertWithSelectedOrderPressed(context, snapshot.data[snapshot.data.length - 1 -  index]),
                      child: Row(
                        //  crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left:30, right: 30),
                            child: Text(snapshot.data[snapshot.data.length - 1 -  index].orderId.toString(),
                                style: TextStyle(fontSize: 18, color: Colors.white)),
                          ),
                          Text(snapshot.data[snapshot.data.length -1 - index].customer.client,
                              style: TextStyle(fontSize: 18, color: Colors.white)),
                          Container(
                            padding: EdgeInsets.only(left:30),
                            child: Text(snapshot.data[snapshot.data.length -1 - index].userName,
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
             // child: Text("${snapshot.error}"),
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

  /// Alert Dialog with Order
  _onAlertWithSelectedOrderPressed(context, Order specific) {
    Alert(
        context: context,
        title:'Order #' + specific.orderId.toString(),
        content: Column(
          children: <Widget>[
            Text("Customer : ${specific.customer.client}"),
            Text("Coords : ${specific.customer.coords}"),
            Text("How to connect : ${specific.customer.connection}"),
            Text("Commentary : ${specific.commentary}"),
            Text("Created by : ${specific.userName}"),
            Text("State : ${specific.orderState.title}"),
            Text("Review status : ${specific.orderReviewState.title}"),
            DropdownButton(items:
            _states.map((orderState) {
              return DropdownMenuItem(
                child: Text(orderState.title),
                value: orderState.title,
              );
            }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _mySelection = newValue;
                    Navigator.pop(context);
                    _onAlertWithSelectedOrderPressed(context, specific);
                  });},
                value: _mySelection),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed:() => Navigator.push(context,
              MaterialPageRoute(builder: (context) => GunInOrderPage(_user, specific.orderId)),
            ),
            child: Text( 'Guns',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),

          DialogButton(
            color: Colors.green,
            onPressed:() {
              debugPrint(_mySelection);
              changeOrderState(_user.token, specific.orderId, _states, _mySelection);
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PrimaryPage(_user,0)),
                      (route) => false);
            },
            child: Text( 'New State',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  /// Alert Dialog with Order Inserting
  _onAlertWithOrderInsertingPressed(context) {
    Alert(
        context: context,
        title: 'New Order',
        content: Column(
          children: <Widget>[
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                icon: Icon(Icons.login),
                labelText: 'Commentary',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed:() {
              if (_commentController.text!='' && _commentController.text!=null) {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GunSelectPage(_user, _commentController.text, gunList)),
                );
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
  void initState() {
    super.initState();
    getOrderStates(_user.token).then((value) {
      setState(() {
        value.forEach((element) {
          _states.add(element);
          // debugPrint(element.title);
        });
        _states.removeAt(2);
        _states.removeAt(2);
        _states.removeAt(0);
        _mySelection = _states[0].title;
      });
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}