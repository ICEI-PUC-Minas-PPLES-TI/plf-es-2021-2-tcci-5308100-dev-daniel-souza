import 'dart:io';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart' as path;
import 'package:sglh/helpers/parse_errors.dart';
import 'package:sglh/helpers/table_keys.dart';
import 'package:sglh/models/auth/user_model.dart';
import 'package:sglh/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAdminRepository {
  List<User> users = List.empty(growable: true);

  Future<List<User>> getAllUsers() async {
    final response = await getAllParseUsers();
    List<User> _users = response
        .map<User>((e) => UserRepository.getUserFromResults(e))
        .toList();

    return _users;
  }

  Future<List<dynamic>> getAllParseUsers() async {
    QueryBuilder<ParseUser> queryUsers =
        QueryBuilder<ParseUser>(ParseUser.forQuery());
    final ParseResponse apiResponse = await queryUsers.query();
    if (apiResponse.success && apiResponse.results != null) {
      // print(apiResponse.results);
      return apiResponse.results!;
    } else {
      return Future.error(apiResponse);
    }
  }

  Future<void> createUser(User user) async {
    ParseUser parseUser = ParseUser(user.email, user.password, user.email);
    parseUser.set<String>(keyUserName, user.name);
    parseUser.set<String>(keyUserType, user.type.name);

    if (user.photo != null) {
      ParseFile parseFile = await getParseFile(user.photo);
      parseUser.set<ParseFile>(keyUserPhoto, parseFile);
    }

    if (user.startDate != null) {
      parseUser.set<DateTime>(keyUserStartDate, user.startDate!);
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? senha = prefs.getString('password');

    final ParseResponse apiResponse = await parseUser.signUp();
    if (apiResponse.success) {
      print('User created');
    } else {
      print(apiResponse.error);
    }
    if (email != null && senha != null) {
      UserRepository.loginWithEmail(email, senha);
    }
  }

  Future<ParseFile> getParseFile(dynamic image) async {
    try {
      if (image is File) {
        final parseFile = ParseFile(image, name: path.basename(image.path));
        final response = await parseFile.save();
        if (!response.success) {
          return Future.error(ParseErrors.getDescription(response.error!.code));
        }
        return parseFile;
      } else {
        final parseFile = ParseFile(null);
        parseFile.name = path.basename(image);
        parseFile.url = image;
        return parseFile;
      }
    } catch (e) {
      return Future.error('Falha ao salvar images.');
    }
  }
}
