// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return Customer(
    json['customerId'] as int,
    json['client'] as String,
    json['coords'] as String,
    json['connection'] as String,
  );
}

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'customerId': instance.customerId,
      'client': instance.client,
      'coords': instance.coords,
      'connection': instance.connection,
    };
