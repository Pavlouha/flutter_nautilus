import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_nautilus/connectionString.dart';
import 'package:flutter_nautilus/models/gun_in_order.dart';
import 'package:flutter_nautilus/models/order.dart';
import 'package:flutter_nautilus/models/order_state.dart';
import 'package:flutter_nautilus/models/user.dart';

///Получаем список заказов - КАПИТАН

Future<List<Order>> getOrders(String token) async {

  Dio dio = new Dio();

  var response = await dio.get(connectionString() + "order", options: Options(headers: {
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

///Получаем список заказов (НЕ ОТМЕНЁННЫХ) - КОНСПИРАТОР

Future<List<Order>> getNotCancelledOrders(String token) async {

  Dio dio = new Dio();

  var response = await dio.get(connectionString() + "ordernotcancelled", options: Options(headers: {
    "Authorization" : "Bearer $token"
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

///Изменяем ордер ревью стейт (КАПИТАН)
Future<bool> changeOrderReviewState(String token, int orderId, int orderReviewStateId) async {

  Dio dio = new Dio();

  FormData formData = FormData.fromMap({
    "id": orderId,
    "orderReviewStateId": orderReviewStateId,
  });

  var response = await dio.patch(connectionString() + "revieworder", data: formData, options: Options(headers: {
    "Authorization" : "Bearer $token"
  }),);

  if (response.statusCode==200) {
    var data = response.data;
    return data;
  } else {
    throw Exception('Failed to change order review state');
  }

}

///Изменяем ордер стейт (КОНСПИРАТОР)
Future<bool> changeOrderState(String token, int orderId, List<OrderState> orderStates, String selected) async {

  int orderStateId;

  orderStates.forEach((element) {
    if (element.title == selected) {
      orderStateId = element.orderStateId;
    }
  });

  Dio dio = new Dio();

  FormData formData = FormData.fromMap({
    "id": orderId,
    "stateId": orderStateId,
  });

  var response = await dio.patch(connectionString() + "order", data: formData, options: Options(headers: {
    "Authorization" : "Bearer $token"
  }),);

  if (response.statusCode==200) {
    var data = response.data;
    return data;
  } else {
    throw Exception('Failed to change order state');
  }

}

///Добавляем новый заказ
Future<bool> insertOrder(int customerId, String commentary, List<GunInOrder> guns, User user) async {

  Dio dio = new Dio();

  debugPrint(customerId.toString());
  debugPrint(commentary);
  debugPrint(user.userId.toString());

  FormData formData = FormData.fromMap({
    "customerId": customerId.toString(),
    "commentary" : commentary,
    "userId" : user.userId.toString(),
  });

  var response = await dio.post(connectionString() + "order", data: formData, options: Options(headers: {
    "Authorization" : "Bearer ${user.token}"
  }),);

  if (response.statusCode==200) {
    var data = response.data;

    ///Отправляем список пушек в новом ордере
    guns.forEach((element) async {

      FormData gunFormData = FormData.fromMap({
        "gunId": element.gun.gunId,
        "quantity": element.quantity,
        "sum": element.sum,
        "orderId": data,
      });

      var response = await dio.post(connectionString() + "newguninorder", data: gunFormData,  options: Options(headers: {
        "Authorization" : "Bearer ${user.token}"
      }),);
    });
    return true;
  } else {
    throw Exception('Failed to add order');
  }

}