import 'package:flutter/material.dart';
import 'package:flutter_nautilus/logic/captain/orders.dart';
import 'package:flutter_nautilus/models/order.dart';
import 'package:flutter_nautilus/models/user.dart';
import 'package:flutter_nautilus/pages/captain/guns_in_order_screen.dart';
import 'package:flutter_nautilus/pages/primary_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OrdersPage extends StatefulWidget {
  final User _user;
  OrdersPage(this._user);

  _OrdersPageState createState() => _OrdersPageState(_user);
}

class _OrdersPageState extends State<OrdersPage> {
  final User _user;
  _OrdersPageState(this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.indigo, elevation: 0,
          title: Text('Order#/Client/Consp', style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(icon: Icon(Icons.update), color: Colors.white, onPressed: () =>
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PrimaryPage(_user,2)),
                        (route) => false)),
          ],),
        body: FutureBuilder<List<Order>>(
          future: getOrders(_user.token), builder: (context, snapshot) {
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
                          onPressed: () => _onAlertWithSelectedOrderPressed(context, snapshot.data[index]),
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
           Text("Commentary : ${specific.commentary}"),
            Text("State : ${specific.orderState.title}"),
            Text("Review status : ${specific.orderReviewState.title}"),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed:() =>Navigator.push(context,
        MaterialPageRoute(builder: (context) => GunInOrderPage(_user, specific.orderId)),
            ),
            child: Text( 'Guns',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          DialogButton(
            color: Colors.green,
            onPressed:() {

            },
            child: Text( 'Done',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          DialogButton(
            color: Colors.red,
            onPressed:() {

            },
            child: Text( 'Cancel',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

}