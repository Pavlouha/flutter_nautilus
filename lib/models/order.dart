import 'package:flutter_nautilus/models/customer.dart';
import 'package:flutter_nautilus/models/order_state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order{
  int id;
  Customer customer;
  String commentary;
  int userId;
  String userName;
  DateTime orderDate;
  OrderState orderState;

  Order(this.id, this.customer, this.commentary, this.userId, this.userName, this.orderDate, this.orderState);

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}