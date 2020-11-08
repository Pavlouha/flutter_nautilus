import 'package:dio/dio.dart';
import 'package:flutter_nautilus/connectionString.dart';
import 'package:flutter_nautilus/models/gun.dart';

///Получаем список пушек
Future<List<Gun>> getGuns(String token) async {

  Dio dio = new Dio();

  var response = await dio.get(connection + "gun",  options: Options(headers: {
    "Authorization" : "Bearer $token"
  }),);

  if (response.statusCode==200) {
    //  debugPrint(response.data.toString());
    var data = response.data as List;
    List<Gun> guns = data.map((e) => Gun.fromJson(e)).toList();
   // debugPrint(guns[0].vendorCode);
    return guns;
  } else {
    throw Exception('Failed to load guns');
  }
}

///Отправляем новую пушку
Future<bool> insertGun(String token, String vendorCode, String price) async {

  Dio dio = new Dio();

  FormData formData = FormData.fromMap({
    "vendorCode": vendorCode,
    "price" : price,
  });

  var response = await dio.post(connection + "gun", data: formData, options: Options(headers: {
    "Authorization" : "Bearer $token"
  }),);

  if (response.statusCode==200) {
    var data = response.data;
    return data;
  } else {
    throw Exception('Failed to insert new gun');
  }
}

///Удаляем пушку
Future<bool> deleteGun(String token, int gunId) async {

  Dio dio = new Dio();

  FormData formData = FormData.fromMap({
    "id": gunId,
  });

  var response = await dio.delete(connection + "gun", data: formData, options: Options(headers: {
    "Authorization" : "Bearer $token"
  }),);

  if (response.statusCode==200) {
    var data = response.data;
    return data;
  } else {
    throw Exception('Failed to delete gun');
  }
}