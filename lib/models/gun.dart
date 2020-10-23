import 'package:json_annotation/json_annotation.dart';

part 'gun.g.dart';

@JsonSerializable()
class Gun{
  int id;
  String vendorCode;
  int price;

  Gun(this.id, this.vendorCode, this.price);

  factory Gun.fromJson(Map<String, dynamic> json) => _$GunFromJson(json);

  Map<String, dynamic> toJson() => _$GunToJson(this);
}