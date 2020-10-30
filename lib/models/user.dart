import 'package:flutter_nautilus/models/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String token;
  int userId;
  String login;
  String username;
  String password;
  Role role;
  String cell;

  User(this.token, this.userId, this.login, this.username, this.password, this.role, this.cell);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}