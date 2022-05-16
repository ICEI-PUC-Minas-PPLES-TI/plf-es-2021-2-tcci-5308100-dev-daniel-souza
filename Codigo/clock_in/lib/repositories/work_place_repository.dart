import 'dart:convert';

import 'package:clock_in/helpers/parse_errors.dart';
import 'package:clock_in/helpers/table_keys.dart';
import 'package:clock_in/models/auth/user_model.dart';
import 'package:clock_in/models/recommendation/work_place_model.dart';
import 'package:clock_in/repositories/user_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class WorkPlaceRepository {
  static Future<WorkPlace?> getUserWorkPlace(User user) async {
    ParseUser parseUser = UserRepository.toParse(user);
    final QueryBuilder workPlaceQueryBuilder =
        QueryBuilder<ParseObject>(ParseObject('WorkPlace'))
          ..whereEqualTo('user_id', parseUser);

    final ParseResponse apiResponse = await workPlaceQueryBuilder.query();
    WorkPlace? workPlace;
    if (apiResponse.success) {
      if (apiResponse.results != null) {
        workPlace = getWorkPlaceFromResults(apiResponse.results!.first, user);
      }
    } else {
      return Future.error(ParseErrors.getDescription(apiResponse.error!.code));
    }

    return workPlace;
  }

  static WorkPlace getWorkPlaceFromResults(ParseObject parseObject, User user) {
    final Map<String, dynamic> object = json.decode(parseObject.toString());
    object.putIfAbsent('user', () => user.toJson());
    object.putIfAbsent('isActive', () => object['is_active']);
    WorkPlace workPlace = WorkPlace.fromJson(object);
    return workPlace;
  }

  static Future<void> saveData(WorkPlace value) async {
    await workPlaceToParse(value);
  }

  static Future<void> workPlaceToParse(WorkPlace workPlace) async {
    ParseObject parseWorkPlace = ParseObject(
      keyWKTable,
      autoSendSessionId: true,
    );
    if (workPlace.objectId != null) {
      parseWorkPlace.set<String>(keyMLTId, workPlace.objectId!);
    }
    ParseUser parseUser = UserRepository.toParse(workPlace.user);
    parseWorkPlace.set(keyMLTUser, parseUser.toPointer());
    parseWorkPlace.set<double>(keyWKLatitude, workPlace.latitude);
    parseWorkPlace.set<double>(keyWKLongitude, workPlace.longitude);
    parseWorkPlace.set<String>(keyWKAddress, workPlace.address);
    parseWorkPlace.set<bool>(keyWKIsActive, workPlace.isActive);

    ParseResponse parseResponse = await parseWorkPlace.save();
    if (!parseResponse.success) {
      throw ParseErrors.getDescription(parseResponse.error!.code);
    }
  }

  static Future<void> deleteData(WorkPlace workPlace) async {
    ParseObject parseWorkPlace = ParseObject(
      keyWKTable,
      autoSendSessionId: true,
    );
    // logical delete
    parseWorkPlace.set<bool>(keyWKIsActive, false);
    parseWorkPlace.set<String>(keyMLTId, workPlace.objectId!);
    ParseUser parseUser = UserRepository.toParse(workPlace.user);
    parseWorkPlace.set(keyMLTUser, parseUser.toPointer());
    parseWorkPlace.set<double>(keyWKLatitude, workPlace.latitude);
    parseWorkPlace.set<double>(keyWKLongitude, workPlace.longitude);
    parseWorkPlace.set<String>(keyWKAddress, workPlace.address);

    ParseResponse parseResponse = await parseWorkPlace.save();
    if (!parseResponse.success) {
      throw ParseErrors.getDescription(parseResponse.error!.code);
    }
  }
}
