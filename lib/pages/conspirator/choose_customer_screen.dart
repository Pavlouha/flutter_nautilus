import 'package:flutter/material.dart';
import 'package:flutter_nautilus/logic/conspirator/clients.dart';
import 'package:flutter_nautilus/logic/orders.dart';
import 'package:flutter_nautilus/models/customer.dart';
import 'package:flutter_nautilus/models/gun_in_order.dart';
import 'package:flutter_nautilus/models/user.dart';
import 'package:flutter_nautilus/pages/primary_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CustomerChoosingPage extends StatefulWidget {
  final User _user;
  final List<GunInOrder> gunsInOrder;
  final String commentary;
  CustomerChoosingPage(this._user, this.gunsInOrder, this.commentary);

  _CustomerChoosingPageState createState() => _CustomerChoosingPageState(_user, gunsInOrder, commentary);
}

class _CustomerChoosingPageState extends State<CustomerChoosingPage> {
  final User _user;
  final List<GunInOrder> gunsInOrder;
  final String commentary;
  _CustomerChoosingPageState(this._user, this.gunsInOrder, this.commentary);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.blueGrey, elevation: 0,
          title: Text('Customers', style: TextStyle(color: Colors.white)),),
        body: FutureBuilder<List<Customer>>(
          future: getClients(_user.token), builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: Colors.blueGrey,
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return FlatButton(
                      padding: EdgeInsets.all(8),
                      onPressed: () {
                        _onAlertWithSelectedCustomerPressed(context, snapshot.data[index]);
                      },
                      child: Row(
                        //  crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left:8, right: 8),
                            child: Text(snapshot.data[index].client,
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
              color: Colors.blueGrey,
              child: Text("${snapshot.error}"),
            );
          }
          return Container(
            color: Colors.blueGrey,
            child: CircularProgressIndicator(),
          );
        },
        )
    );
  }

  /// Alert Dialog with Customer
  _onAlertWithSelectedCustomerPressed(context, Customer specific) {
    Alert(
        context: context,
        title:'Customer #' + specific.customerId.toString(),
        content: Column(
          children: <Widget>[
            Text("Name : ${specific.client}"),
            Text("Where : ${specific.coords}"),
            Text("How : ${specific.connection}"),
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.green,
            onPressed:() {
              insertOrder(specific.customerId, commentary, gunsInOrder, _user).then((value) {
                if (value = true) {
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PrimaryPage(_user, 0)),
                          (route) => false);
                } else {
                  debugPrint(value.toString());
                }
              }
              );
            },
            child: Text( 'Publish',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}