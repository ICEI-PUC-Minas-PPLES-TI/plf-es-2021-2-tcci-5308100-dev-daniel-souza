import 'package:clock_in/stores/auth_store.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:clock_in/helpers/extensions.dart';
import 'package:clock_in/models/auth/user_model.dart';
import 'package:clock_in/repositories/user_admin_repository.dart';

part 'add_user_store_copy.g.dart';

class AddUserStoreCopy = _AddUserStoreCopy with _$AddUserStoreCopy;

abstract class _AddUserStoreCopy with Store {
  final Map<String, UserType> userTypeMap = {
    "Comum": UserType.user,
    "Administrador": UserType.admin,
  };

  final Map<UserType, String> userTypeMapReverse = {
    UserType.user: "Comum",
    UserType.admin: "Administrador",
  };

  _AddUserStoreCopy(this.user);

  User user;

  @observable
  String _name = '';

  @observable
  String _email = '';

  @observable
  String _password = '';

  @observable
  String _passwordConfirm = '';

  @observable
  String _error = '';

  @computed
  bool get isValid {
    return _name.isNotEmpty &&
        _email.isNotEmpty &&
        _password.isNotEmpty &&
        _passwordConfirm.isNotEmpty &&
        _password == _passwordConfirm;
  }

  @computed
  String get error {
    return _error;
  }

  @action
  void setName(String name) => _name = name;

  @action
  void setEmail(String email) => _email = email;

  @action
  void setPassword(String password) => _password = password;

  @action
  void setPasswordConfirm(String passwordConfirm) =>
      _passwordConfirm = passwordConfirm;

  @action
  Future<void> saveData() async {}

  @observable
  String post = "Trainee";

  @observable
  List<String> roles = ["Trainee", "Software Engineer", "Project Manager"];

  @observable
  UserType userType = UserType.user;

  @computed
  String? get userTypeString => userTypeMapReverse[userType];

  @action
  void setUserType(String? value) {
    final selectedType = userTypeMap[value];
    if (value != null && selectedType != null) {
      userType = selectedType;
    }
  }

  @action
  void setPost(String? value) {
    if (value != null) {
      post = value;
    }
  }

  @observable
  bool isFormValid = true;
}
