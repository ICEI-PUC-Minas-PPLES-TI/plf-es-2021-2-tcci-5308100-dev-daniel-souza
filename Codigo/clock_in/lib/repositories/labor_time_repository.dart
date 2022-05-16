import 'dart:convert';

import 'package:clock_in/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:clock_in/helpers/mock/month_labor_time_mock.dart';
import 'package:clock_in/helpers/parse_errors.dart';
import 'package:clock_in/helpers/table_keys.dart';
import 'package:clock_in/models/auth/user_model.dart';
import 'package:clock_in/models/hours_management/month_labor_time_model.dart';
import 'package:clock_in/models/hours_management/time_period_model.dart';
import 'package:clock_in/repositories/user_repository.dart';

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
    if (apiResponse.success) {
      if (apiResponse.results != null) {
        monthLaborTimes = apiResponse.results!
            .map((element) =>
                getMonthLaborTimeFromResults(element as ParseObject, user))
            .toList();
      } else {
        return createInitialMonthLaborTime(user);
      }
    } else {
      return Future.error(ParseErrors.getDescription(apiResponse.error!.code));
    }

    final QueryBuilder laborTimeQueryBuilder =
        QueryBuilder<ParseObject>(ParseObject('LaborTime'));

    List<Map<String, dynamic>> parseMonthLaborTimes = monthLaborTimes.map((e) {
      ParseObject parseObject = ParseObject('MonthLaborTime');
      parseObject.objectId = e.objectId!;
      return parseObject.toPointer();
    }).toList();

    laborTimeQueryBuilder.whereContainedIn(
        'month_labor_time_id', parseMonthLaborTimes);

    final ParseResponse laborTimeResponse = await laborTimeQueryBuilder.query();

    List<LaborTime> laborTimes = [];
    if (!laborTimeResponse.success) {
      debugPrint("Falha ao buscar LaborTimes");
      return Future.error(
          ParseErrors.getDescription(laborTimeResponse.error!.code));
    }
    if (laborTimeResponse.results != null) {
      laborTimes = laborTimeResponse.results!
          .map((element) => getLaborTimeFromResults(element as ParseObject))
          .toList();
    }

    final QueryBuilder timePeriodQueryBuilder =
        QueryBuilder<ParseObject>(ParseObject('TimePeriod'));

    List<Map<String, dynamic>> parseLaborTimes = laborTimes.map((e) {
      ParseObject parseObject = ParseObject('LaborTime');
      parseObject.objectId = e.objectId!;
      return parseObject.toPointer();
    }).toList();
    timePeriodQueryBuilder.whereContainedIn('labor_time_id', parseLaborTimes);

    final ParseResponse timePeriodsResponse =
        await timePeriodQueryBuilder.query();

    List<TimePeriod> timePeriods = List<TimePeriod>.empty(growable: true);
    if (timePeriodsResponse.success) {
      if (timePeriodsResponse.results != null) {
        timePeriods = timePeriodsResponse.results!
            .map((element) => getTimePeriodFromResults(element as ParseObject))
            .toList();
      }
    } else {
      debugPrint('timePeriodsResponse error');
      debugPrint(ParseErrors.getDescription(timePeriodsResponse.error!.code));

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
    final Map<String, dynamic> object = json.decode(parseObject.toString());
    TimePeriod timePeriod = TimePeriod.fromJson(object);
    return timePeriod;
  }

  static MonthLaborTime updateLaborTimeList(
      MonthLaborTime mlt, List<LaborTime> lts) {
    return mlt.copyWith(laborTimeList: lts);
  }

  static List<MonthLaborTime> createMissingLaborTimes(
    List<MonthLaborTime> monthLaborTimes,
  ) {
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
      status: "Em lançamento",
      monthReference: now.getMonthReference(),
    );

    monthLaborTimeList.add(
      initialMonthLaborTime.copyWith(
        laborTimeList: initialMonthLaborTime.createLaborTime(),
      ),
    );
    return monthLaborTimeList;
  }

  static Future<void> saveClockInData(List<MonthLaborTime> value) async {
    // for (final e in value) {
    //   print('${e.laborTimeList.length} items');
    //   for (final e in e.laborTimeList) {
    //     print(e);
    //     for (final e in e.clockInList) {
    //       print(e);
    //     }
    //   }
    // }
    for (var element in value) {
      await monthLaborTimeToParse(element);
    }
  }

  static Future<ParseObject> monthLaborTimeToParse(
    MonthLaborTime monthLaborTime,
  ) async {
    ParseObject parseMonthLaborTime = ParseObject(
      keyMLTTable,
      autoSendSessionId: true,
    );
    if (monthLaborTime.objectId != null) {
      parseMonthLaborTime.set<String>(keyMLTId, monthLaborTime.objectId!);
    }
    ParseUser parseUser = UserRepository.toParse(monthLaborTime.user);
    parseMonthLaborTime.set(keyMLTUser, parseUser.toPointer());
    parseMonthLaborTime.set<int>(keyMLTYear, monthLaborTime.year);
    parseMonthLaborTime.set<int>(keyMLTMonth, monthLaborTime.month);
    parseMonthLaborTime.set<String?>(keyMLTStatus, monthLaborTime.status);

    if (parseMonthLaborTime.objectId == null) {
      ParseResponse parseResponse = await parseMonthLaborTime.save();
      if (!parseResponse.success) {
        debugPrint('parseResponse error');
        debugPrint(ParseErrors.getDescription(parseResponse.error!.code));
      }
    }

    for (var element in monthLaborTime.laborTimeList) {
      laborTimeToParse(element, parseMonthLaborTime);
    }
    return parseMonthLaborTime;
  }

  static Future<ParseObject> laborTimeToParse(
    LaborTime laborTime,
    ParseObject parseMonthLaborTime,
  ) async {
    ParseObject parseLaborTime = ParseObject(
      keyLTTable,
      autoSendSessionId: true,
    );
    parseLaborTime.set(keyLTMLTId, parseMonthLaborTime.toPointer());

    parseLaborTime.set<int>(keyLTDayOfMonth, laborTime.date.day);
    parseLaborTime.set<DateTime>(keyLTDate, laborTime.date);
    parseLaborTime.set<double>(
        keyLTTotalHours, laborTime.calculateTotalHours());
    parseLaborTime.set<String>(keyLTTypeOfDay, laborTime.dayOfWeekType.name);

    if (laborTime.objectId != null) {
      parseLaborTime.set<String>(keyLTId, laborTime.objectId!);
    }
    ParseResponse parseResponse = await parseLaborTime.save();
    if (!parseResponse.success) {
      debugPrint('parseLaborTime response');
      debugPrint(ParseErrors.getDescription(parseResponse.error!.code));
    }

    for (var element in laborTime.clockInList) {
      timePeriodToParse(element, parseLaborTime);
    }
    return parseLaborTime;
  }

  static Future<ParseObject> timePeriodToParse(
    TimePeriod timePeriod,
    ParseObject parseLaborTime,
  ) async {
    ParseObject parseTimePeriod = ParseObject(
      keyTMTable,
      autoSendSessionId: true,
    );
    if (timePeriod.objectId != null) {
      parseTimePeriod.set<String>(keyTMId, timePeriod.objectId!);
    }

    parseTimePeriod.set(keyTMLTId, parseLaborTime.toPointer());

    if (timePeriod.startingTime != null) {
      parseTimePeriod.set<DateTime>(keyTMStartTime, timePeriod.startingTime!);
    }
    if (timePeriod.endingTime != null) {
      parseTimePeriod.set<DateTime>(keyTMEndTime, timePeriod.endingTime!);
    }
    parseTimePeriod.set<double>(keyTMNormalHours, timePeriod.getHoursWorked());

    ParseResponse parseResponse = await parseTimePeriod.save();

    if (!parseResponse.success) {
      debugPrint('parseTimePeriod error response');
      debugPrint(ParseErrors.getDescription(parseResponse.error!.code));
    }
    return parseTimePeriod;
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

  static Future<void> requestApproval(MonthLaborTime monthLaborTime) async {
    ParseObject parseMonthLaborTime = ParseObject(
      keyMLTTable,
      autoSendSessionId: true,
    );
    parseMonthLaborTime.set<String>(keyMLTId, monthLaborTime.objectId!);

    // Fixo em função da aprovação acontecer somente na versão do app com integração do SYDLE ONE
    parseMonthLaborTime.set<String>(
      keyMLTStatus,
      monthLaborTime.status != null && monthLaborTime.status == "Aprovado"
          ? "Em lançamento"
          : "Aprovado",
    );
    ParseResponse parseResponse = await parseMonthLaborTime.save();
    if (!parseResponse.success) {
      debugPrint('parseResponse error');
      debugPrint(ParseErrors.getDescription(parseResponse.error!.code));
    }
  }
}
