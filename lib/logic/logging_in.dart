import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nautilus/connectionString.dart';
import 'package:flutter_nautilus/models/user.dart';
import 'package:barbarian/barbarian.dart';

ifLoginAndPassExist() async {

  if (Barbarian.read('login') == null ) {
    return false;
  } else {
    return true;
  }
}

addDataToSP(String login, String password) async {
  Barbarian.write('login', login);
  Barbarian.write('password', password);
}

getLoginSF() async {
  String str = Barbarian.read('login');
  return str;
}

getPasswordSF() async {
  String str = Barbarian.read('password');
  return str;
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
    response = await dio.post(connectionString() + "generatetoken", data: jsonEncode(formData), options: Options(headers: {
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