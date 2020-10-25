import 'package:flutter/material.dart';
import 'package:flutter_nautilus/pages/login_screen.dart';

void main() {
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