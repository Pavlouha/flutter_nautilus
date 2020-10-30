// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gun_in_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GunInOrder _$GunInOrderFromJson(Map<String, dynamic> json) {
  return GunInOrder(
    json['gunInOrderId'] as int,
    json['gun'] == null
        ? null
        : Gun.fromJson(json['gun'] as Map<String, dynamic>),
    json['quantity'] as int,
    json['sum'] as int,
    json['orderId'] as int,
    json['gunState'] == null
        ? null
        : GunState.fromJson(json['gunState'] as Map<String, dynamic>),
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
