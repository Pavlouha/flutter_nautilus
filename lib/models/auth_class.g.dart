// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthClass _$AuthClassFromJson(Map<String, dynamic> json) {
  return AuthClass(
    json['authId'] as int,
    json['loginDate'] as String,
    json['user'] as String,
    json['userId'] as int,
  );
}

Map<String, dynamic> _$AuthClassToJson(AuthClass instance) => <String, dynamic>{
      'authId': instance.authId,
      'loginDate': instance.loginDate,
      'user': instance.user,
      'userId': instance.userId,
    };
