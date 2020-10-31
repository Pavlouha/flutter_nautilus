// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    json['orderId'] as int,
    Customer(json['customer']['customerId'] as int, json['customer']['client'] as String,
      json['customer']['coords'] as String, json['customer']['connection'] as String,),
    json['commentary'] as String,
    json['userId'] as int,
    json['userName'] as String,
    json['orderDate'] as String,
    OrderState(json['orderState']['orderStateId'] as int, json['orderState']['title'] as String),
    OrderReviewState(json['orderReviewState']['orderReviewStateId'] as int, json['orderReviewState']['title'] as String),
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'orderId': instance.orderId,
      'customer': instance.customer,
      'commentary': instance.commentary,
      'userId': instance.userId,
      'userName': instance.userName,
      'orderDate': instance.orderDate,
      'orderState': instance.orderState,
      'orderReviewState': instance.orderReviewState,
    };
