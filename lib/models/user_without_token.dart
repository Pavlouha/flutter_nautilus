import 'package:flutter_nautilus/models/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_without_token.g.dart';

@JsonSerializable()
class UserWithoutToken {
  int userId;
  String login;
  String username;
  String password;
  Role role;
  String cell;

  UserWithoutToken(this.userId, this.login, this.username, this.password, this.role, this.cell);

  factory UserWithoutToken.fromJson(Map<String, dynamic> json) => _$UserWithoutTokenFromJson(json);

  Map<String, dynamic> toJson() => _$UserWithoutTokenToJson(this);
}