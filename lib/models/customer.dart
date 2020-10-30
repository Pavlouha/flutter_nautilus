import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer{
  int customerId;
  String client;
  String coords;
  String connection;

  Customer(this.customerId, this.client, this.coords, this.connection);

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}