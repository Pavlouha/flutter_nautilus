import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_nautilus/models/role.dart';

import '../../connectionString.dart';

///Получаем список ролей

Future<List<Role>> getRoles(String token) async {

  Dio dio = new Dio();

  var response = await dio.get(connection + "role", options: Options(headers: {
    HttpHeaders.contentTypeHeader: "application/json", "Authorization" : "Bearer $token"
  }),);
  return parseRoles(response);
}

List<Role> parseRoles(Response response) {
  if (response.statusCode==200) {
     debugPrint(response.data.toString());
    var data = response.data as List;
    List<Role> roles = data.map((e) => Role.fromJson(e)).toList();
    return roles;
  } else {
    throw Exception('Failed to load roles');
  }
}