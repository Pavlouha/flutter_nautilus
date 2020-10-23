import 'package:flutter_nautilus/models/abstract/state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gun_state.g.dart';

@JsonSerializable()
class GunState extends State{
  int id;
  String title;

  GunState(this.id, this.title) : super(id, title);

  factory GunState.fromJson(Map<String, dynamic> json) => _$GunStateFromJson(json);

  Map<String, dynamic> toJson() => _$GunStateToJson(this);
}