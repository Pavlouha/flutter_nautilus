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

  var response = await dio.post(connection + "guninorder", data: formData,  options: Options(headers: {
    "Authorization" : "Bearer $token"
  }),);

  debugPrint(response.data.toString());

  if (response.statusCode==200) {
    var data = response.data as List;
    List<GunInOrder> gunsInOrder = data.map((e) => GunInOrder.fromJson(e)).toList();
    return gunsInOrder;
  } else {
    throw Exception('Failed to load Guns In Order');
  }
}