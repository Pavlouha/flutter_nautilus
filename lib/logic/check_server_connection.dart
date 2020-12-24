import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nautilus/connectionString.dart';

Future<bool> checkServerConnection() async {
  Response response;
  Dio dio = new Dio();
  try {
    response = await dio.get(connectionString());

  if (response.statusCode==200) {
    return true;
  } else {
    return false;
  }
  } catch (e) {
    debugPrint(e.toString());
  }
}