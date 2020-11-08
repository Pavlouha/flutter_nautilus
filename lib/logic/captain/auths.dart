import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_nautilus/connectionString.dart';
import 'package:flutter_nautilus/models/auth_class.dart';

///Получаем список AUTH объектов

Future<List<AuthClass>> authorizationList(String token) async {

  Dio dio = new Dio();

   var response = await dio.get(connectionString() + "auths", options: Options(headers: {
      HttpHeaders.contentTypeHeader: "application/json", "Authorization" : "Bearer $token"
    }),);

   return parseAuths(response);
}

List<AuthClass> parseAuths(Response response) {
  if (response.statusCode==200) {
    var data = response.data as List;
    List<AuthClass> auths = data.map((e) => AuthClass.fromJson(e)).toList();
    return auths;
  } else {
    throw Exception('Failed to load auths');
  }
}

///Удаляем все объекты

Future<bool> authorizationDelete(String token) async {

  Dio dio = new Dio();

  var response = await dio.delete(connectionString() + "auths", options: Options(headers: {
    HttpHeaders.contentTypeHeader: "application/json", "Authorization" : "Bearer $token"
  }),);

  if (response.statusCode==200) {
    var data = response.data;
    return data;
  } else {
    throw Exception('Failed to delete auths');
  }


}