import 'dart:convert';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:clock_in/helpers/parse_errors.dart';
import 'package:clock_in/helpers/table_keys.dart';
import 'package:clock_in/models/auth/user_model.dart';

class UserRepository {
  static Future<User?> signUp(User user) async {
    final ParseUser parseUser =
        ParseUser(user.email, user.password, user.email);
    parseUser.set<String>(keyUserName, user.name);

    final ParseResponse response = await parseUser.signUp();

    if (response.success) {
      return getUserFromResults(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }

  static ParseUser toParse(User user) {
    ParseUser parseUser = ParseUser(user.email, user.password, user.email);
    parseUser.set<String?>(keyUserId, user.objectId);
    parseUser.set<String?>(keyUserName, user.name);
    parseUser.set<String?>(keyUserEmail, user.email);
    parseUser.set<String?>(keyUserPost, user.post);
    parseUser.set<String?>(keyUserType, user.type.toString());
    parseUser.set<DateTime?>(keyUserCreatedAt, user.createdAt);
    parseUser.set<DateTime?>(keyUserStartDate, user.startDate);
    parseUser.set<bool>(keyUserIsActive, user.isActive);
    parseUser.set<int>(keyUserScheduleHours, user.scheduleHours);

    return parseUser;
  }

  static User getUserFromResults(ParseUser parseUser) {
    final Map<String, dynamic> userJson = json.decode(parseUser.toString());
    userJson.putIfAbsent('email', () => userJson['username']);
    User userFromJson = User.fromJson(userJson);
    return userFromJson;
  }

  static Future<User?> loginWithEmail(String email, String password) async {
    final ParseUser parseUser = ParseUser(email.trim(), password, null);

    final ParseResponse response = await parseUser.login();

    if (response.success) {
      return getUserFromResults(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }

  static Future<User?> currentUser() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) {
      return null;
    }
    //Checks whether the user's session token is valid
    final ParseResponse? parseResponse =
        await ParseUser.getCurrentUserFromServer(currentUser.sessionToken!);

    if (parseResponse?.success == null || !parseResponse!.success) {
      //Invalid session. Logout
      await currentUser.logout();
      return null;
    } else {
      return getUserFromResults(parseResponse.result);
    }
  }
}
