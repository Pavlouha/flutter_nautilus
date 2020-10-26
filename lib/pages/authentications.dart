import 'package:flutter/material.dart';
import 'package:flutter_nautilus/logic/auths.dart';
import 'package:flutter_nautilus/models/auth_class.dart';
import 'package:flutter_nautilus/models/user.dart';
import 'package:flutter_nautilus/pages/primary_screen.dart';

class AuthsPage extends StatefulWidget {
  final User _user;
  AuthsPage(this._user);

   _AuthsPageState createState() => _AuthsPageState(_user);
}

class _AuthsPageState extends State<AuthsPage> {
  final User _user;
  _AuthsPageState(this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueGrey, elevation: 0,
      title: Text('date/users', style: TextStyle(color: Colors.white)),
      actions: [
        IconButton(icon: Icon(Icons.update), color: Colors.white, onPressed: () =>
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PrimaryPage(_user)),
                (route) => false)),
        IconButton(icon: Icon(Icons.delete), color: Colors.white,
            onPressed: () {
          authorizationDelete(_user.token).then((value) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PrimaryPage(_user)),
                    (route) => false);
          }
          );
            }
        ),
      ],),
      body: FutureBuilder<List<AuthClass>>(
        future: authorizationList(_user.token), builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            color: Colors.blueGrey,
            padding: EdgeInsets.only(top: 20),
              child: Center(
                child: ListView.builder(
                     padding: const EdgeInsets.only(left: 8, right: 8),
                     itemCount: snapshot.data.length,
                     itemBuilder: (context, index) {
                       return Container(
                         padding: EdgeInsets.all(8),
                         child: Row(
                           //  crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Container(
                               padding: EdgeInsets.only(left:30, right: 60),
                               child: Text(snapshot.data[snapshot.data.length - 1 -  index].loginDate,
                                   style: TextStyle(fontSize: 18, color: Colors.white)),
                             ),
                             Text(snapshot.data[snapshot.data.length -1 - index].user, style: TextStyle(fontSize: 18, color: Colors.white)),
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
}