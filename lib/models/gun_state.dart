import 'package:flutter_nautilus/models/abstract/state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gun_state.g.dart';

@JsonSerializable()
class GunState extends State{
  int gunStateId;
  String title;

  GunState(this.gunStateId, this.title) : super();

  factory GunState.fromJson(Map<String, dynamic> json) => _$GunStateFromJson(json);

  Map<String, dynamic> toJson() => _$GunStateToJson(this);
}