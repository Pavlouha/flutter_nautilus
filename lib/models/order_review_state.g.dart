// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_review_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderReviewState _$OrderReviewStateFromJson(Map<String, dynamic> json) {
  return OrderReviewState(
    json['orderReviewStateId'] as int,
    json['title'] as String,
  );
}

Map<String, dynamic> _$OrderReviewStateToJson(OrderReviewState instance) =>
    <String, dynamic>{
      'orderReviewStateId': instance.orderReviewStateId,
      'title': instance.title,
    };
