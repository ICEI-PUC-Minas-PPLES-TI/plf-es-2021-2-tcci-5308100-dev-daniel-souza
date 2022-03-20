import 'dart:convert';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:sglh/helpers/mock/month_labor_time_mock.dart';
import 'package:sglh/helpers/parse_errors.dart';
import 'package:sglh/helpers/table_keys.dart';
import 'package:sglh/models/auth/user_model.dart';
import 'package:sglh/models/hours_management/month_labor_time_model.dart';
import 'package:sglh/models/hours_management/time_period_model.dart';
import 'package:sglh/repositories/user_repository.dart';

import '../models/hours_management/labor_time_model.dart';

class LaborTimeRepository {
  static Future<List<MonthLaborTime>> getClockInData() async {
    List<MonthLaborTime> mltList = await getData();
    return mltList;
  }

  static Future<List<MonthLaborTime>> getClockInDataFromUser(User user) async {
    List<MonthLaborTime> mltList = List<MonthLaborTime>.empty(growable: true);

    ParseUser parseUser = UserRepository.toParse(user);
    final QueryBuilder mltQueryBuilder =
        QueryBuilder<ParseObject>(ParseObject('MonthLaborTime'))
          ..whereEqualTo('user_id', parseUser);

    final ParseResponse apiResponse = await mltQueryBuilder.query();
    List<MonthLaborTime> monthLaborTimes = [];
    if (apiResponse.success && apiResponse.results != null) {
      if (apiResponse.results!.isEmpty) {
        return createInitialMonthLaborTime(user);
      }
      monthLaborTimes = apiResponse.results!
          .map((element) =>
              getMonthLaborTimeFromResults(element as ParseObject, user))
          .toList();
    } else {
      return Future.error(ParseErrors.getDescription(apiResponse.error!.code));
    }

    final QueryBuilder laborTimeQueryBuilder =
        QueryBuilder<ParseObject>(ParseObject('LaborTime'));
    for (var element in monthLaborTimes) {
      ParseObject p = ParseObject('MonthLaborTime')
        ..set<String>('objectId', element.objectId!);

      laborTimeQueryBuilder.whereEqualTo("month_labor_time_id", p);
    }

    final ParseResponse laborTimeResponse = await laborTimeQueryBuilder.query();

    List<LaborTime> laborTimes = [];
    if (laborTimeResponse.success && laborTimeResponse.results != null) {
      laborTimes = laborTimeResponse.results!
          .map((element) => getLaborTimeFromResults(element as ParseObject))
          .toList();
    } else {
      return Future.error(
          ParseErrors.getDescription(laborTimeResponse.error!.code));
    }

    final QueryBuilder timePeriodQueryBuilder =
        QueryBuilder<ParseObject>(ParseObject('TimePeriod'));

    // for (var element in laborTimes) {
    //   ParseObject p = ParseObject('LaborTime')
    //     ..set<String>('objectId', element.objectId!);
    //   timePeriodQueryBuilder.whereEqualTo("labor_time_id", p);
    // }
    List<Map<String, dynamic>> parseLaborTimes = laborTimes.map((e) {
      ParseObject parseObject = ParseObject('LaborTime');
      parseObject.objectId = e.objectId!;
      return parseObject.toPointer();
    }).toList();
    timePeriodQueryBuilder.whereContainedIn('labor_time_id', parseLaborTimes);

    final ParseResponse timePeriodsResponse =
        await timePeriodQueryBuilder.query();

    print(timePeriodsResponse.results);
    List<TimePeriod> timePeriods = List<TimePeriod>.empty(growable: true);
    if (timePeriodsResponse.success) {
      if (timePeriodsResponse.results != null) {
        timePeriods = timePeriodsResponse.results!
            .map((element) => getTimePeriodFromResults(element as ParseObject))
            .toList();
      }
    } else {
      print(ParseErrors.getDescription(timePeriodsResponse.error!.code));
      return Future.error(
          ParseErrors.getDescription(timePeriodsResponse.error!.code));
    }

    for (var element in laborTimes) {
      element.clockInList.addAll(timePeriods
          .where((timePeriod) => timePeriod.laborTimeId == element.objectId));
    }

    for (var element in monthLaborTimes) {
      mltList.add(
        element.copyWith(
            laborTimeList: laborTimes
                .where((lt) => lt.monthLaborTimeId == element.objectId)
                .toList(growable: true)),
      );
    }

    return createMissingLaborTimes(mltList);
  }

  static MonthLaborTime getMonthLaborTimeFromResults(
      ParseObject parseObject, User user) {
    final Map<String, dynamic> object = json.decode(parseObject.toString());
    object.putIfAbsent('user', () => user.toJson());
    int? month = parseObject.get<int>(keyMLTMonth);
    int? year = parseObject.get<int>(keyMLTYear);
    if (month != null && year != null) {
      object.putIfAbsent('monthReference', () => '$month/$year');
    }
    MonthLaborTime monthLaborTimeFromJson = MonthLaborTime.fromJson(object);
    return monthLaborTimeFromJson;
  }

  static LaborTime getLaborTimeFromResults(ParseObject parseObject) {
    final Map<String, dynamic> object = json.decode(parseObject.toString());
    var date = object['date']; // in order to convert parse object date to Date
    object.update('date', (value) => date['iso']);
    LaborTime laborTime = LaborTime.fromJson(object);
    return laborTime;
  }

  static TimePeriod getTimePeriodFromResults(ParseObject parseObject) {
    print("parseObject.get<DateTime>(keyTMStartTime)");
    print(parseObject.get<DateTime>(keyTMStartTime));
    final Map<String, dynamic> object = json.decode(parseObject.toString());
    TimePeriod timePeriod = TimePeriod.fromJson(object);
    return timePeriod;
  }

  static MonthLaborTime updateLaborTimeList(
      MonthLaborTime mlt, List<LaborTime> lts) {
    return mlt.copyWith(laborTimeList: lts);
  }

  static List<MonthLaborTime> createMissingLaborTimes(
      List<MonthLaborTime> monthLaborTimes) {
    List<MonthLaborTime> returningList = [];
    for (final element in monthLaborTimes) {
      List<LaborTime> allLaborTimes = element.generateMissingLaborTime();
      returningList.add(element.copyWith(laborTimeList: allLaborTimes));
    }
    return returningList;
  }

  static List<MonthLaborTime> createInitialMonthLaborTime(User user) {
    List<MonthLaborTime> monthLaborTimeList = [];
    final now = DateTime.now();
    MonthLaborTime initialMonthLaborTime = MonthLaborTime(
      user: user,
      year: now.year,
      month: now.month,
      status: "Em Lançamento",
    );
    monthLaborTimeList.add(
      initialMonthLaborTime.copyWith(
        laborTimeList: initialMonthLaborTime.createLaborTime(),
      ),
    );
    return monthLaborTimeList;
  }

  static Future<void> saveClockInData(List<MonthLaborTime> value) async {
    for (final e in value) {
      print('${e.laborTimeList.length} items');
      for (final e in e.laborTimeList) {
        print(e);
        for (final e in e.clockInList) {
          print(e);
        }
      }
    }
    for (var element in value) {
      await monthLaborTimeToParse(element);
    }
  }

  static Future<void> monthLaborTimeToParse(
      MonthLaborTime monthLaborTime) async {
    ParseObject parseMonthLaborTime = ParseObject(
      keyMLTTable,
      autoSendSessionId: true,
    );
    if (monthLaborTime.objectId != null) {
      parseMonthLaborTime.set<String>(keyMLTId, monthLaborTime.objectId!);
    }
    ParseUser parseUser = UserRepository.toParse(monthLaborTime.user);
    parseMonthLaborTime.set<ParseUser>(keyMLTUser, parseUser);
    parseMonthLaborTime.set<int>(keyMLTYear, monthLaborTime.year);
    parseMonthLaborTime.set<int>(keyMLTMonth, monthLaborTime.month);
    parseUser.set<String?>(keyMLTStatus, monthLaborTime.status);
    // return parseMonthLaborTime;
    print(parseMonthLaborTime);
    for (var element in monthLaborTime.laborTimeList) {
      laborTimeToParse(element);
    }
    if (parseMonthLaborTime.objectId == null) {
      ParseResponse parseResponse = await parseMonthLaborTime.create();
      print(parseResponse);
    }
  }

  // static ParseObject laborTimeToParse(LaborTime laborTime) {
  static Future<void> laborTimeToParse(LaborTime laborTime) async {
    ParseObject parseLaborTime = ParseObject(
      keyLTTable,
      autoSendSessionId: true,
    );
    if (laborTime.objectId != null) {
      parseLaborTime.set<String>(keyLTId, laborTime.objectId!);
    }
    if (laborTime.monthLaborTimeId != null) {
      ParseObject parseMonthLaborTime = ParseObject(keyMLTTable)
        ..set<String>(keyMLTId, laborTime.monthLaborTimeId!);
      parseLaborTime.set<ParseObject>(keyLTMLTId, parseMonthLaborTime);
    }
    parseLaborTime.set<int>(keyLTDayOfMonth, laborTime.date.day);
    parseLaborTime.set<DateTime>(keyLTDate, laborTime.date);
    parseLaborTime.set<double>(
        keyLTTotalHours, laborTime.calculateTotalHours());
    parseLaborTime.set<String>(keyLTTypeOfDay, laborTime.dayOfWeekType.name);
    // ParseResponse parseResponse = await parseLaborTime.save();
    // print('parseResponse');
    // print(parseResponse.success);
    for (var element in laborTime.clockInList) {
      timePeriodToParse(element);
    }
  }

  static Future<void> timePeriodToParse(TimePeriod timePeriod) async {
    ParseObject parseTimePeriod = ParseObject(
      keyTMTable,
      autoSendSessionId: true,
    );
    if (timePeriod.objectId != null) {
      parseTimePeriod.set<String>(keyTMId, timePeriod.objectId!);
    }
    if (timePeriod.laborTimeId != null) {
      ParseObject parseLaborTime = ParseObject(keyLTTable)
        ..set<String>(keyLTId, timePeriod.laborTimeId!);
      parseTimePeriod.set<ParseObject>(keyTMLTId, parseLaborTime);
    }
    if (timePeriod.startingTime != null) {
      print('timePeriod.startingTime');
      print(timePeriod.startingTime);
      print(timePeriod.startingTime?.toIso8601String());
      print(timePeriod.startingTime?.isUtc);
      parseTimePeriod.set<DateTime>(keyTMStartTime, timePeriod.startingTime!);
    }
    if (timePeriod.endingTime != null) {
      parseTimePeriod.set<DateTime>(keyTMEndTime, timePeriod.endingTime!);
    }
    parseTimePeriod.set<double>(keyTMNormalHours, timePeriod.getHoursWorked());
    // TODO special_hours
    // return parseTimePeriod;

    ParseResponse parseResponse = await parseTimePeriod.save();
  }

  static Future<String?> deleteTimePeriod(TimePeriod timePeriod) async {
    if (timePeriod.objectId == null) {
      return null;
    }
    ParseObject parseTimePeriod = ParseObject(keyTMTable)
      ..objectId = timePeriod.objectId!;
    ParseResponse parseResponse = await parseTimePeriod.delete();
    if (!parseResponse.success && parseResponse.error != null) {
      return ParseErrors.getDescription(parseResponse.error!.code);
    }
    return null;
  }
}
