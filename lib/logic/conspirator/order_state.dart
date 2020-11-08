import 'package:dio/dio.dart';
import 'package:flutter_nautilus/models/order_state.dart';

import '../../connectionString.dart';

///Получаем список стейтов заказа

Future<List<OrderState>> getOrderStates(String token) async {

  Dio dio = new Dio();

  var response = await dio.get(connection + "orderstate", options: Options(headers: {
     "Authorization" : "Bearer $token"
  }),);
  return parseOrderStates(response);
}

List<OrderState> parseOrderStates(Response response) {
  if (response.statusCode==200) {
  //  debugPrint(response.data.toString());
    var data = response.data as List;
    List<OrderState> states = data.map((e) => OrderState.fromJson(e)).toList();
    return states;
  } else {
    throw Exception('Failed to load order states');
  }
}