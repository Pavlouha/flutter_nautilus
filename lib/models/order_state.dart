import 'package:flutter_nautilus/models/abstract/state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_state.g.dart';

@JsonSerializable()
class OrderState extends State{
  int id;
  String title;

  OrderState(this.id, this.title) : super(id, title);

  factory OrderState.fromJson(Map<String, dynamic> json) => _$OrderStateFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStateToJson(this);
}