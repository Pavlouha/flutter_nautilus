import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nautilus/connectionString.dart';
import 'package:flutter_nautilus/models/user.dart';

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
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return user;
}