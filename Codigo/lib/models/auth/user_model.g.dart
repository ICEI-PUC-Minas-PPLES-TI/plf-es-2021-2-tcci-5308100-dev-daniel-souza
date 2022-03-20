// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      objectId: json['objectId'] as String?,
      photo: json['photo'],
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      name: json['name'] as String,
      email: json['email'] as String,
      post: json['post'] as String?,
      password: json['password'] as String?,
      scheduleHours: json['scheduleHours'] as int? ?? 8,
      type:
          $enumDecodeNullable(_$UserTypeEnumMap, json['type']) ?? UserType.user,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'objectId': instance.objectId,
      'photo': instance.photo,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'startDate': instance.startDate?.toIso8601String(),
      'name': instance.name,
      'email': instance.email,
      'post': instance.post,
      'password': instance.password,
      'scheduleHours': instance.scheduleHours,
      'type': _$UserTypeEnumMap[instance.type],
    };

const _$UserTypeEnumMap = {
  UserType.user: 'user',
  UserType.admin: 'admin',
};
