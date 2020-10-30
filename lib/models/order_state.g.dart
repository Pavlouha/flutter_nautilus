// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderState _$OrderStateFromJson(Map<String, dynamic> json) {
  return OrderState(
    json['orderStateId'] as int,
    json['title'] as String,
  );
}

Map<String, dynamic> _$OrderStateToJson(OrderState instance) =>
    <String, dynamic>{
      'orderStateId': instance.orderStateId,
      'title': instance.title,
    };
