import 'package:dio/dio.dart';
import 'package:flutter_nautilus/models/gun_in_order.dart';
import 'package:flutter_nautilus/models/gun_state.dart';
import 'package:flutter_nautilus/connectionString.dart';

///Получаем список всех ганинордеров
Future<List<GunInOrder>> getAllGunsInOrder(String token) async {

  Dio dio = new Dio();

  var response = await dio.get(connectionString() + "guninorder", options: Options(headers: {
    "Authorization" : "Bearer $token"
  }),);

//  debugPrint(response.data.toString());

  if (response.statusCode==200) {
    var data = response.data as List;
    List<GunInOrder> gunsInOrder = data.map((e) => GunInOrder.fromJson(e)).toList();
    return gunsInOrder;
  } else {
    throw Exception('Failed to load Guns In Order');
  }
}

///Изменяем ган стейт (ОРУЖЕЙНИК)
Future<bool> changeGunState(String token, int orderId, List<GunState> gunStates, String selected) async {

  int gunStateId;

  gunStates.forEach((element) {
    if (element.title == selected) {
      gunStateId = element.gunStateId;
    }
  });

  Dio dio = new Dio();

  FormData formData = FormData.fromMap({
    "orderId": orderId,
    "stateId": gunStateId,
  });

  var response = await dio.patch(connectionString() + "guninorder", data: formData, options: Options(headers: {
    "Authorization" : "Bearer $token"
  }),);

  if (response.statusCode==200) {
    var data = response.data;
    return data;
  } else {
    throw Exception('Failed to change gun state');
  }

}