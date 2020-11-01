import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_nautilus/connectionString.dart';
import 'package:flutter_nautilus/models/customer.dart';
import 'package:flutter_nautilus/models/role.dart';

//TODO сделать клиентов

///Получаем список кастомеров
Future<List<Customer>> getClients(String token) async {

  Dio dio = new Dio();

  var response = await dio.get(connection + "user", options: Options(headers: {
    HttpHeaders.contentTypeHeader: "application/json", "Authorization" : "Bearer $token"
  }),);
  return parseClients(response);
}

List<Customer> parseClients(Response response) {
  if (response.statusCode==200) {
    // debugPrint(response.data.toString());
    var data = response.data as List;
    List<Customer> clients = data.map((e) => Customer.fromJson(e)).toList();
    return clients;
  } else {
    throw Exception('Failed to load customers');
  }
}

///Удаляем кастомера
Future<bool> deleteClient(String token, int id) async {

  Dio dio = new Dio();

  var formData = {
    "id": id,
  };

  var response = await dio.delete(connection + "user", data: jsonEncode(formData), options: Options(headers: {
    HttpHeaders.contentTypeHeader: "application/json", "Authorization" : "Bearer $token"
  }),);

  if (response.statusCode==200) {
    var data = response.data;
    return data;
  } else {
    throw Exception('Failed to delete user ');
  }

}

///Добавляем нового клиента
Future<bool> insertClient( String token) async {

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

  var response = await dio.post(connection + "user", data: formData, options: Options(headers: {
    "Authorization" : "Bearer $token"
  }),);

  if (response.statusCode==200) {
    var data = response.data;
    return data;
  } else {
    throw Exception('Failed to add user');
  }

}