import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nautilus/connectionString.dart';
import 'package:flutter_nautilus/models/gun_in_order.dart';


///Получаем список пушек

Future<List<GunInOrder>> getGunsInOrder(String token, int orderId) async {

  Dio dio = new Dio();

  FormData formData = FormData.fromMap({
    "id": orderId,
  });

  var response = await dio.get(connection + "guninorder", data: formData,  options: Options(headers: {
    HttpHeaders.contentTypeHeader: "application/json", "Authorization" : "Bearer $token"
  }),);

  if (response.statusCode==200) {
    var data = response.data as List;
    List<GunInOrder> gunsInOrder = data.map((e) => GunInOrder.fromJson(e)).toList();
    return gunsInOrder;
  } else {
    throw Exception('Failed to load Guns In Order');
  }
}