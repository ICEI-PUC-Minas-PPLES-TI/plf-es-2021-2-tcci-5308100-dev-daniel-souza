// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WorkPlace _$$_WorkPlaceFromJson(Map<String, dynamic> json) => _$_WorkPlace(
      objectId: json['objectId'] as String?,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String,
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$$_WorkPlaceToJson(_$_WorkPlace instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'user': instance.user,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'isActive': instance.isActive,
    };
