// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['token'] as String,
    json['id'] as int,
    json['login'] as String,
    json['username'] as String,
    json['password'] as String,
    Role(json['roleId'] as int, json['title'] as String),
    json['cell'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'token': instance.token,
      'id': instance.id,
      'login': instance.login,
      'username': instance.username,
      'password': instance.password,
      'roleId': instance.role.id,
  'title': instance.role.title,
      'cell': instance.cell,
    };
