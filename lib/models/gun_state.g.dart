// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gun_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GunState _$GunStateFromJson(Map<String, dynamic> json) {
  return GunState(
    json['gunStateId'] as int,
    json['title'] as String,
  );
}

Map<String, dynamic> _$GunStateToJson(GunState instance) => <String, dynamic>{
      'gunStateId': instance.gunStateId,
      'title': instance.title,
    };
