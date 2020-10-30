// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gun.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gun _$GunFromJson(Map<String, dynamic> json) {
  return Gun(
    json['gunId'] as int,
    json['vendorCode'] as String,
    json['price'] as int,
  );
}

Map<String, dynamic> _$GunToJson(Gun instance) => <String, dynamic>{
      'gunId': instance.gunId,
      'vendorCode': instance.vendorCode,
      'price': instance.price,
    };
