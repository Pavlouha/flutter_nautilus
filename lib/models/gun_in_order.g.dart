// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gun_in_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GunInOrder _$GunInOrderFromJson(Map<String, dynamic> json) {
  return GunInOrder(
    json['gunInOrderId'] as int,
    Gun(json['gun']['gunId'] as int, json['gun']['vendor_code'] as String, json['gun']['price'] as int),
    json['quantity'] as int,
    json['sum'] as int,
    json['orderId'] as int,
    GunState(json['gunState']['gunStateId'] as int, json['gunState']['title'] as String),
  );
}

Map<String, dynamic> _$GunInOrderToJson(GunInOrder instance) =>
    <String, dynamic>{
      'gunInOrderId': instance.gunInOrderId,
      'gun': instance.gun,
      'quantity': instance.quantity,
      'sum': instance.sum,
      'orderId': instance.orderId,
      'gunState': instance.gunState,
    };
