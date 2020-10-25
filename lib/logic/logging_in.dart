import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nautilus/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO ПАЧИМУ НЕ РОБОТОЕТ ШАРЕДПРЕФС

ifLoginAndPassExist() async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('login');
}

addDataToSP(String login, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('login', login);
  prefs.setString('password', password);
}

getLoginSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString('login');
  return stringValue;
}

getPasswordSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString('password');
  return stringValue;
}

Future<User> authorization(String login, String password) async {
  Response response;
  Dio dio = new Dio();
  User user;
  try {
    var formData = {
      "name": login,
      "password": password,
    };
    response = await dio.post("http://195.2.78.182:8080/generatetoken", data: jsonEncode(formData), options: Options(headers: {
    HttpHeaders.contentTypeHeader: "application/json",
    }),);

    if (response.statusCode==200) {
      Map<String, dynamic> data = response.data;
       user = User.fromJson(data);
      if(ifLoginAndPassExist() == false) {
        addDataToSP(login, password);
        debugPrint(ifLoginAndPassExist().toString());
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return user;
}