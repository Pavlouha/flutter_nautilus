import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_nautilus/connectionString.dart';
import 'package:flutter_nautilus/models/role.dart';
import 'package:flutter_nautilus/models/user_without_token.dart';

/// Получаем список пользователей
Future<List<UserWithoutToken>> getUsers(String token) async {

  Dio dio = new Dio();

  var response = await dio.get(connectionString() + "user", options: Options(headers: {
    HttpHeaders.contentTypeHeader: "application/json", "Authorization" : "Bearer $token"
  }),);
  return parseUsers(response);
}

List<UserWithoutToken> parseUsers(Response response) {
  if (response.statusCode==200) {
   // debugPrint(response.data.toString());
    var data = response.data as List;
    List<UserWithoutToken> users = data.map((e) => UserWithoutToken.fromJson(e)).toList();
    return users;
  } else {
    throw Exception('Failed to load users');
  }
}

/// Удаляем юзера
Future<String> deleteUser(String token, int id) async {

  Dio dio = new Dio();

  FormData formData = FormData.fromMap({
    "id": id,
  });

  var response = await dio.delete(connectionString() + "user", data: formData, options: Options(headers: {"Authorization" : "Bearer $token"
  }),);

  if (response.statusCode==200) {
    var data = response.data;
    return data;
  } else {
    throw Exception('Failed to delete user');
  }

}

///Добавляем нового пользователя

Future<bool> insertUser(String login, String password, List<Role> roles, String roleTitle, String username, String cell, String token) async {

  Dio dio = new Dio();

  int roleId;

  roles.forEach((element) {
    if (element.title == roleTitle) {
      roleId = element.roleId;
    }
  });

  FormData formData = FormData.fromMap({
    "login": login,
    "password" : password,
    "roleId" : roleId.toString(),
    "username" : username,
    "cell" : cell
  });

  var response = await dio.post(connectionString() + "user", data: formData, options: Options(headers: {
    "Authorization" : "Bearer $token"
  }),);

  if (response.statusCode==200) {
    var data = response.data;
    return data;
  } else {
    throw Exception('Failed to add user');
  }

}