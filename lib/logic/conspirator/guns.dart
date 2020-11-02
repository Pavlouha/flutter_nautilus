import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nautilus/connectionString.dart';
import 'package:flutter_nautilus/models/gun.dart';

///Получаем список пушек
Future<List<Gun>> getGuns(String token) async {

  Dio dio = new Dio();

  var response = await dio.get(connection + "gun",  options: Options(headers: {
    "Authorization" : "Bearer $token"
  }),);

  debugPrint(response.data.toString());

  if (response.statusCode==200) {
    var data = response.data as List;
    List<Gun> guns = data.map((e) => Gun.fromJson(e)).toList();
    return guns;
  } else {
    throw Exception('Failed to load guns');
  }
}