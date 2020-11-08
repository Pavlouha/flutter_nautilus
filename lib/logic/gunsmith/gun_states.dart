import 'package:dio/dio.dart';
import 'package:flutter_nautilus/models/gun_state.dart';

import 'package:flutter_nautilus/connectionString.dart';

///Получаем список стейтов волын

Future<List<GunState>> getGunStates(String token) async {

  Dio dio = new Dio();

  var response = await dio.get(connectionString() + "gunstate", options: Options(headers: {
    "Authorization" : "Bearer $token"
  }),);
  return parseGunStates(response);
}

List<GunState> parseGunStates(Response response) {
  if (response.statusCode==200) {
    //  debugPrint(response.data.toString());
    var data = response.data as List;
    List<GunState> states = data.map((e) => GunState.fromJson(e)).toList();
    return states;
  } else {
    throw Exception('Failed to load gun states');
  }
}