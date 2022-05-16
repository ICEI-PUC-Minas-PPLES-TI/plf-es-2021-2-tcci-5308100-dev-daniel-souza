// import 'dart:core';

// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:clock_in/models/hours_management/time_period_model.dart';

// part 'labor_time_model.freezed.dart';
// part 'labor_time_model.g.dart';

// enum TypeOfDay { businessDay, weekend, holiday }

// @freezed
// class LaborTime with _$LaborTime {
//   const LaborTime._();
//   const factory LaborTime({
//     String? objectId,
//     String? monthLaborTimeId,
//     required DateTime date,
//     @Default(<TimePeriod>[]) List<TimePeriod> clockInList,
//     @Default(TypeOfDay.businessDay) TypeOfDay? typeOfDay,
//   }) = _LaborTime;

//   static const Map<int, Map<String, String>> dayOfWeekMap = {
//     1: <String, String>{
//       "prefix": "SEG",
//       "name": "Segunda-feira",
//       "type": "businessDay"
//     },
//     2: <String, String>{
//       "prefix": "TER",
//       "name": "Terça-feira",
//       "type": "businessDay"
//     },
//     3: <String, String>{
//       "prefix": "QUA",
//       "name": "Quarta-feira",
//       "type": "businessDay"
//     },
//     4: <String, String>{
//       "prefix": "QUI",
//       "name": "Quinta-feira",
//       "type": "businessDay"
//     },
//     5: <String, String>{
//       "prefix": "SEX",
//       "name": "Sexta-feira",
//       "type": "businessDay"
//     },
//     6: <String, String>{"prefix": "SAB", "name": "Sábado", "type": "weekend"},
//     7: <String, String>{"prefix": "DOM", "name": "Domingo", "type": "weekend"},
//   };

//   int get dayOfMonth => date.day;
//   // String get dayOfWeekName => dayOfWeekMap[date.weekday]['name'];
//   // String get dayOfWeekPrefix => dayOfWeekMap[date.weekday]['prefix'];
//   // String get dayOfWeekType => dayOfWeekMap[date.weekday]['type'];

//   factory LaborTime.fromJson(Map<String, dynamic> json) =>
//       _$LaborTimeFromJson(json);
// }

import 'dart:core';

import 'package:clock_in/models/hours_management/time_period_model.dart';

enum TypeOfDay { businessDay, weekend, holiday }

class LaborTime {
  LaborTime({
    this.objectId,
    this.monthLaborTimeId,
    required this.date,
  }) : typeOfDay = dayOfWeekMap[date.weekday]!['type'];

  String? objectId;
  String? monthLaborTimeId;
  late DateTime date;
  List<TimePeriod> clockInList = List<TimePeriod>.empty(growable: true);
  TypeOfDay? typeOfDay;

  static const Map<int, Map<String, dynamic>> dayOfWeekMap = {
    1: <String, dynamic>{
      "prefix": "SEG",
      "name": "Segunda-feira",
      "type": TypeOfDay.businessDay
    },
    2: <String, dynamic>{
      "prefix": "TER",
      "name": "Terça-feira",
      "type": TypeOfDay.businessDay
    },
    3: <String, dynamic>{
      "prefix": "QUA",
      "name": "Quarta-feira",
      "type": TypeOfDay.businessDay
    },
    4: <String, dynamic>{
      "prefix": "QUI",
      "name": "Quinta-feira",
      "type": TypeOfDay.businessDay
    },
    5: <String, dynamic>{
      "prefix": "SEX",
      "name": "Sexta-feira",
      "type": TypeOfDay.businessDay
    },
    6: <String, dynamic>{
      "prefix": "SAB",
      "name": "Sábado",
      "type": TypeOfDay.weekend
    },
    7: <String, dynamic>{
      "prefix": "DOM",
      "name": "Domingo",
      "type": TypeOfDay.weekend
    },
  };

  int get dayOfMonth => date.day;
  String get dayOfWeekName => dayOfWeekMap[date.weekday]!['name'];
  String get dayOfWeekPrefix => dayOfWeekMap[date.weekday]!['prefix'];
  TypeOfDay get dayOfWeekType => dayOfWeekMap[date.weekday]!['type'];

  LaborTime.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    date = DateTime.parse(json['date']);
    if (json.containsKey(monthLaborTimeId)) {
      monthLaborTimeId = json['monthLaborTimeId'];
    }
    if (json.containsKey('month_labor_time_id')) {
      var mltId = json['month_labor_time_id'];
      monthLaborTimeId = mltId['objectId'];
    }
    if (json.containsKey('clockInList')) {
      clockInList = (json['clockInList'] as List)
          .map((e) => TimePeriod.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    typeOfDay = date.weekday != 0 && date.weekday != 6
        ? TypeOfDay.businessDay
        : TypeOfDay.weekend;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['monthLaborTimeId'] = monthLaborTimeId;
    data['date'] = date.toIso8601String();
    data['clockInList'] = clockInList.map((e) => e.toJson()).toList();
    data['typeOfDay'] = typeOfDay;
    return data;
  }

  @override
  String toString() {
    return "LaborTime(objectId: $objectId, monthLaborTimeId: $monthLaborTimeId, date: $date, clockInList: $clockInList)";
  }

  double calculateTotalHours() {
    if (clockInList.isEmpty) {
      return 0;
    }
    return clockInList.fold(0.0, (previousValue, element) {
      return previousValue + element.getHoursWorked();
    });
  }
}
