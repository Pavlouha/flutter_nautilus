import 'package:json_annotation/json_annotation.dart';

part 'auth_class.g.dart';

@JsonSerializable()
class AuthClass{
  int id;
  DateTime loginDate;
  String user;
  int userId;

  AuthClass(this.id, this.loginDate, this.user, this.userId);

  factory AuthClass.fromJson(Map<String, dynamic> json) => _$AuthClassFromJson(json);

  Map<String, dynamic> toJson() => _$AuthClassToJson(this);
}