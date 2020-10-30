import 'package:flutter_nautilus/models/gun_state.dart';
import 'package:json_annotation/json_annotation.dart';

import 'gun.dart';

part 'gun_in_order.g.dart';

@JsonSerializable()
class GunInOrder{
  int gunInOrderId;
  Gun gun;
  int quantity;
  int sum;
  int orderId;
  GunState gunState;

  GunInOrder(this.gunInOrderId, this.gun, this.quantity, this.sum, this.orderId, this.gunState);

  factory GunInOrder.fromJson(Map<String, dynamic> json) => _$GunInOrderFromJson(json);

  Map<String, dynamic> toJson() => _$GunInOrderToJson(this);
}