// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthClass _$AuthClassFromJson(Map<String, dynamic> json) {
  return AuthClass(
    json['id'] as int,
    json['loginDate'] == null
        ? null
        : DateTime.parse(json['loginDate'] as String),
    json['user'] as String,
    json['userId'] as int,
  );
}

Map<String, dynamic> _$AuthClassToJson(AuthClass instance) => <String, dynamic>{
      'id': instance.id,
      'loginDate': instance.loginDate?.toIso8601String(),
      'user': instance.user,
      'userId': instance.userId,
    };