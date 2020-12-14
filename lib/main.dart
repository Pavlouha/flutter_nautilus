
import 'package:flutter/material.dart';
import 'package:flutter_nautilus/pages/login_screen.dart';
import 'package:airship_flutter/airship_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Barbarian.init();

  //TODO попробовать сделать условия для уведомлений (потом)

  Airship.setUserNotificationsEnabled(true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nautilus',
    /*  theme: ThemeData(
        primarySwatch: Colors.black,
      ), */
      home: LoginPage(),
      );
  }
}