import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_nautilus/connectionString.dart';
import 'package:flutter_nautilus/models/order.dart';
import 'package:flutter_nautilus/models/order_state.dart';

///Получаем список заказов - КАПИТАН

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

///Получаем список заказов (НЕ ОТМЕНЁННЫХ) - КОНСПИРАТОР

Future<List<Order>> getNotCancelledOrders(String token) async {

  Dio dio = new Dio();

  var response = await dio.get(connection + "ordernotcancelled", options: Options(headers: {
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

  var response = await dio.patch(connection + "revieworder", data: formData, options: Options(headers: {
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

//TODO сделать добавление заказа

///Добавляем новый заказ
Future<bool> insertOrder(String login, String password, List<Role> roles, String roleTitle, String username, String cell, String token) async {

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