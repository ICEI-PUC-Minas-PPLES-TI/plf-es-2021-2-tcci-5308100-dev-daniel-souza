// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_user_store_copy.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddUserStoreCopy on _AddUserStoreCopy, Store {
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
          name: '_AddUserStoreCopy.isValid'))
      .value;
  Computed<String>? _$errorComputed;

  @override
  String get error => (_$errorComputed ??=
          Computed<String>(() => super.error, name: '_AddUserStoreCopy.error'))
      .value;
  Computed<String?>? _$userTypeStringComputed;

  @override
  String? get userTypeString => (_$userTypeStringComputed ??= Computed<String?>(
          () => super.userTypeString,
          name: '_AddUserStoreCopy.userTypeString'))
      .value;

  late final _$_nameAtom =
      Atom(name: '_AddUserStoreCopy._name', context: context);

  @override
  String get _name {
    _$_nameAtom.reportRead();
    return super._name;
  }

  @override
  set _name(String value) {
    _$_nameAtom.reportWrite(value, super._name, () {
      super._name = value;
    });
  }

  late final _$_emailAtom =
      Atom(name: '_AddUserStoreCopy._email', context: context);

  @override
  String get _email {
    _$_emailAtom.reportRead();
    return super._email;
  }

  @override
  set _email(String value) {
    _$_emailAtom.reportWrite(value, super._email, () {
      super._email = value;
    });
  }

  late final _$_passwordAtom =
      Atom(name: '_AddUserStoreCopy._password', context: context);

  @override
  String get _password {
    _$_passwordAtom.reportRead();
    return super._password;
  }

  @override
  set _password(String value) {
    _$_passwordAtom.reportWrite(value, super._password, () {
      super._password = value;
    });
  }

  late final _$_passwordConfirmAtom =
      Atom(name: '_AddUserStoreCopy._passwordConfirm', context: context);

  @override
  String get _passwordConfirm {
    _$_passwordConfirmAtom.reportRead();
    return super._passwordConfirm;
  }

  @override
  set _passwordConfirm(String value) {
    _$_passwordConfirmAtom.reportWrite(value, super._passwordConfirm, () {
      super._passwordConfirm = value;
    });
  }

  late final _$_errorAtom =
      Atom(name: '_AddUserStoreCopy._error', context: context);

  @override
  String get _error {
    _$_errorAtom.reportRead();
    return super._error;
  }

  @override
  set _error(String value) {
    _$_errorAtom.reportWrite(value, super._error, () {
      super._error = value;
    });
  }

  late final _$postAtom =
      Atom(name: '_AddUserStoreCopy.post', context: context);

  @override
  String get post {
    _$postAtom.reportRead();
    return super.post;
  }

  @override
  set post(String value) {
    _$postAtom.reportWrite(value, super.post, () {
      super.post = value;
    });
  }

  late final _$rolesAtom =
      Atom(name: '_AddUserStoreCopy.roles', context: context);

  @override
  List<String> get roles {
    _$rolesAtom.reportRead();
    return super.roles;
  }

  @override
  set roles(List<String> value) {
    _$rolesAtom.reportWrite(value, super.roles, () {
      super.roles = value;
    });
  }

  late final _$userTypeAtom =
      Atom(name: '_AddUserStoreCopy.userType', context: context);

  @override
  UserType get userType {
    _$userTypeAtom.reportRead();
    return super.userType;
  }

  @override
  set userType(UserType value) {
    _$userTypeAtom.reportWrite(value, super.userType, () {
      super.userType = value;
    });
  }

  late final _$isFormValidAtom =
      Atom(name: '_AddUserStoreCopy.isFormValid', context: context);

  @override
  bool get isFormValid {
    _$isFormValidAtom.reportRead();
    return super.isFormValid;
  }

  @override
  set isFormValid(bool value) {
    _$isFormValidAtom.reportWrite(value, super.isFormValid, () {
      super.isFormValid = value;
    });
  }

  late final _$saveDataAsyncAction =
      AsyncAction('_AddUserStoreCopy.saveData', context: context);

  @override
  Future<void> saveData() {
    return _$saveDataAsyncAction.run(() => super.saveData());
  }

  late final _$_AddUserStoreCopyActionController =
      ActionController(name: '_AddUserStoreCopy', context: context);

  @override
  void setName(String name) {
    final _$actionInfo = _$_AddUserStoreCopyActionController.startAction(
        name: '_AddUserStoreCopy.setName');
    try {
      return super.setName(name);
    } finally {
      _$_AddUserStoreCopyActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String email) {
    final _$actionInfo = _$_AddUserStoreCopyActionController.startAction(
        name: '_AddUserStoreCopy.setEmail');
    try {
      return super.setEmail(email);
    } finally {
      _$_AddUserStoreCopyActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String password) {
    final _$actionInfo = _$_AddUserStoreCopyActionController.startAction(
        name: '_AddUserStoreCopy.setPassword');
    try {
      return super.setPassword(password);
    } finally {
      _$_AddUserStoreCopyActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPasswordConfirm(String passwordConfirm) {
    final _$actionInfo = _$_AddUserStoreCopyActionController.startAction(
        name: '_AddUserStoreCopy.setPasswordConfirm');
    try {
      return super.setPasswordConfirm(passwordConfirm);
    } finally {
      _$_AddUserStoreCopyActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserType(String? value) {
    final _$actionInfo = _$_AddUserStoreCopyActionController.startAction(
        name: '_AddUserStoreCopy.setUserType');
    try {
      return super.setUserType(value);
    } finally {
      _$_AddUserStoreCopyActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPost(String? value) {
    final _$actionInfo = _$_AddUserStoreCopyActionController.startAction(
        name: '_AddUserStoreCopy.setPost');
    try {
      return super.setPost(value);
    } finally {
      _$_AddUserStoreCopyActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
post: ${post},
roles: ${roles},
userType: ${userType},
isFormValid: ${isFormValid},
isValid: ${isValid},
error: ${error},
userTypeString: ${userTypeString}
    ''';
  }
}
