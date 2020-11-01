import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nautilus/connectionString.dart';
import 'package:flutter_nautilus/models/order.dart';


///Получаем список заказов

Future<List<Order>> getOrders(String token) async {

  Dio dio = new Dio();

  var response = await dio.get(connection + "order", options: Options(headers: {
    HttpHeaders.contentTypeHeader: "application/json", "Authorization" : "Bearer $token"
  }),);

  if (response.statusCode==200) {
    var data = response.data as List;
    List<Order> orders = data.map((e) => Order.fromJson(e)).toList();
    orders.forEach((element) {
     // debugPrint(element.userName);
    });
    return orders;
  } else {
    throw Exception('Failed to load orders');
  }
}

///Изменяем ордер

Future<bool> changeOrderState(String token, int orderId, int stateId) async {

  Dio dio = new Dio();

  FormData formData = FormData.fromMap({
    "id": orderId,
    "stateId": stateId,
  });

  var response = await dio.patch(connection + "order", data: formData, options: Options(headers: {
    "Authorization" : "Bearer $token"
  }),);

  if (response.statusCode==200) {
    var data = response.data;
    return data;
  } else {
    throw Exception('Failed to change order state');
  }

}