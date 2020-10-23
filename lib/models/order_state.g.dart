// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderState _$OrderStateFromJson(Map<String, dynamic> json) {
  return OrderState(
    json['id'] as int,
    json['title'] as String,
  );
}

Map<String, dynamic> _$OrderStateToJson(OrderState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
