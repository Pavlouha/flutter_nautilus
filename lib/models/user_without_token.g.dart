// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_without_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWithoutToken _$UserWithoutTokenFromJson(Map<String, dynamic> json) {
  return UserWithoutToken(
    json['userId'] as int,
    json['login'] as String,
    json['username'] as String,
    json['password'] as String,
    Role(json['role']['roleId'] as int, json['role']['title'] as String),
    json['cell'] as String,
  );
}

Map<String, dynamic> _$UserWithoutTokenToJson(UserWithoutToken instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'login': instance.login,
      'username': instance.username,
      'password': instance.password,
      'role': instance.role,
      'cell': instance.cell,
    };
