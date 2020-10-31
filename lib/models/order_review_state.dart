import 'package:flutter_nautilus/models/abstract/state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_review_state.g.dart';

@JsonSerializable()
class OrderReviewState extends State{
  int orderReviewStateId;
  String title;

  OrderReviewState(this.orderReviewStateId, this.title) : super();

  factory OrderReviewState.fromJson(Map<String, dynamic> json) => _$OrderReviewStateFromJson(json);

  Map<String, dynamic> toJson() => _$OrderReviewStateToJson(this);
}