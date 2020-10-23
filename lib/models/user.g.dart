// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as int,
    json['login'] as String,
    json['username'] as String,
    json['password'] as String,
    json['role'] == null
        ? null
        : Role.fromJson(json['role'] as Map<String, dynamic>),
    json['cell'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'username': instance.username,
      'password': instance.password,
      'role': instance.role,
      'cell': instance.cell,
    };
