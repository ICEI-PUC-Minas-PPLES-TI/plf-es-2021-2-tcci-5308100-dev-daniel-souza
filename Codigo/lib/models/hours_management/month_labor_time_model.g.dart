// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'month_labor_time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MonthLaborTime _$$_MonthLaborTimeFromJson(Map<String, dynamic> json) =>
    _$_MonthLaborTime(
      objectId: json['objectId'] as String?,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      year: json['year'] as int,
      month: json['month'] as int,
      status: json['status'] as String?,
      monthReference: json['monthReference'] as String?,
      laborTimeList: (json['laborTimeList'] as List<dynamic>?)
              ?.map((e) => LaborTime.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <LaborTime>[],
    );

Map<String, dynamic> _$$_MonthLaborTimeToJson(_$_MonthLaborTime instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'user': instance.user,
      'year': instance.year,
      'month': instance.month,
      'status': instance.status,
      'monthReference': instance.monthReference,
      'laborTimeList': instance.laborTimeList,
    };
