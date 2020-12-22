import 'package:flutter/material.dart';
import 'package:flutter_nautilus/logic/conspirator/clients.dart';
import 'package:flutter_nautilus/models/customer.dart';
import 'package:flutter_nautilus/models/user.dart';
import 'package:flutter_nautilus/pages/primary_screen.dart';
import 'package:flutter_nautilus/widgets/delete_error_alert.dart';
import 'package:flutter_nautilus/widgets/no_data_entered_alert.dart';
import 'package:flutter_nautilus/widgets/server_error_alert.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CustomerPage extends StatefulWidget {
  final User _user;
  CustomerPage(this._user);

  _CustomerPageState createState() => _CustomerPageState(_user);
}

class _CustomerPageState extends State<CustomerPage> {
  final User _user;
  _CustomerPageState(this._user);

  final _clientController = TextEditingController();
  final _coordsController = TextEditingController();
  final _connectionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.blueGrey, elevation: 0,
          title: Text('Customers', style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(icon: Icon(Icons.update), color: Colors.white, onPressed: () =>
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PrimaryPage(_user,0)),
                        (route) => false)),
            IconButton(icon: Icon(Icons.add_circle), color: Colors.white,
                onPressed:() => _onAlertWithCustomerInsertingPressed(context))
          ],),
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
            //  child: Text("${snapshot.error}"),
              child: Text("Server error"),
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
            color: Colors.red,
            onPressed:() {
              deleteClient(_user.token, specific.customerId).then((value) {
                  if (value == "true") {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PrimaryPage(_user, 0)),
                            (route) => false);
                  } else if (value=="false") {
                    deleteError(context);
                  } else {
                    serverError(context);
                    debugPrint(value.toString());
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

  /// Alert Dialog with Customer Inserting
  _onAlertWithCustomerInsertingPressed(context) {
    Alert(
        context: context,
        title: 'New Customer',
        content: Column(
          children: <Widget>[
            TextField(
              controller: _clientController,
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: _coordsController,
              decoration: InputDecoration(
                icon: Icon(Icons.location_on),
                labelText: 'Coordinates',
              ),
            ),
            TextField(
              controller: _connectionController,
              decoration: InputDecoration(
                icon: Icon(Icons.location_searching),
                labelText: 'How to connect',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed:() {
              if (_coordsController.text!='' && _connectionController.text!='' && _clientController.text!='') {
                insertClient(_clientController.text, _coordsController.text, _connectionController.text, _user.token).then((value) {
                  if (value != null) {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PrimaryPage(_user,1)),
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
    _clientController.dispose();
    _connectionController.dispose();
    _coordsController.dispose();
    super.dispose();
  }
}