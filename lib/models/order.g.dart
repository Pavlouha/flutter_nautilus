// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    json['orderId'] as int,
    json['customer'] == null
        ? null
        : Customer.fromJson(json['customer'] as Map<String, dynamic>),
    json['commentary'] as String,
    json['userId'] as int,
    json['userName'] as String,
    json['orderDate'] == null
        ? null
        : DateTime.parse(json['orderDate'] as String),
    json['orderState'] == null
        ? null
        : OrderState.fromJson(json['orderState'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'orderId': instance.orderId,
      'customer': instance.customer,
      'commentary': instance.commentary,
      'userId': instance.userId,
      'userName': instance.userName,
      'orderDate': instance.orderDate?.toIso8601String(),
      'orderState': instance.orderState,
    };
