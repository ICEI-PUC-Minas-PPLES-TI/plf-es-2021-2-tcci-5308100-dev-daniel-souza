// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddUserStore on _AddUserStore, Store {
  Computed<String?>? _$userTypeStringComputed;

  @override
  String? get userTypeString => (_$userTypeStringComputed ??= Computed<String?>(
          () => super.userTypeString,
          name: '_AddUserStore.userTypeString'))
      .value;
  Computed<bool>? _$nameValidComputed;

  @override
  bool get nameValid =>
      (_$nameValidComputed ??= Computed<bool>(() => super.nameValid,
              name: '_AddUserStore.nameValid'))
          .value;
  Computed<dynamic>? _$nameErrorComputed;

  @override
  dynamic get nameError =>
      (_$nameErrorComputed ??= Computed<dynamic>(() => super.nameError,
              name: '_AddUserStore.nameError'))
          .value;
  Computed<bool>? _$emailValidComputed;

  @override
  bool get emailValid =>
      (_$emailValidComputed ??= Computed<bool>(() => super.emailValid,
              name: '_AddUserStore.emailValid'))
          .value;
  Computed<dynamic>? _$postErrorComputed;

  @override
  dynamic get postError =>
      (_$postErrorComputed ??= Computed<dynamic>(() => super.postError,
              name: '_AddUserStore.postError'))
          .value;
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_AddUserStore.isFormValid'))
          .value;
  Computed<dynamic>? _$signupPressedComputed;

  @override
  dynamic get signupPressed =>
      (_$signupPressedComputed ??= Computed<dynamic>(() => super.signupPressed,
              name: '_AddUserStore.signupPressed'))
          .value;
  Computed<bool>? _$showErrorsComputed;

  @override
  bool get showErrors =>
      (_$showErrorsComputed ??= Computed<bool>(() => super.showErrors,
              name: '_AddUserStore.showErrors'))
          .value;

  final _$nameAtom = Atom(name: '_AddUserStore.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$emailAtom = Atom(name: '_AddUserStore.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$photoAtom = Atom(name: '_AddUserStore.photo');

  @override
  dynamic get photo {
    _$photoAtom.reportRead();
    return super.photo;
  }

  @override
  set photo(dynamic value) {
    _$photoAtom.reportWrite(value, super.photo, () {
      super.photo = value;
    });
  }

  final _$postAtom = Atom(name: '_AddUserStore.post');

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

  final _$rolesAtom = Atom(name: '_AddUserStore.roles');

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

  final _$userTypeAtom = Atom(name: '_AddUserStore.userType');

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

  final _$startDateAtom = Atom(name: '_AddUserStore.startDate');

  @override
  DateTime get startDate {
    _$startDateAtom.reportRead();
    return super.startDate;
  }

  @override
  set startDate(DateTime value) {
    _$startDateAtom.reportWrite(value, super.startDate, () {
      super.startDate = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_AddUserStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$errorAtom = Atom(name: '_AddUserStore.error');

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$userCreatedAtom = Atom(name: '_AddUserStore.userCreated');

  @override
  bool get userCreated {
    _$userCreatedAtom.reportRead();
    return super.userCreated;
  }

  @override
  set userCreated(bool value) {
    _$userCreatedAtom.reportWrite(value, super.userCreated, () {
      super.userCreated = value;
    });
  }

  final _$userSavedFormAtom = Atom(name: '_AddUserStore.userSavedForm');

  @override
  bool get userSavedForm {
    _$userSavedFormAtom.reportRead();
    return super.userSavedForm;
  }

  @override
  set userSavedForm(bool value) {
    _$userSavedFormAtom.reportWrite(value, super.userSavedForm, () {
      super.userSavedForm = value;
    });
  }

  final _$_signUpAsyncAction = AsyncAction('_AddUserStore._signUp');

  @override
  Future<void> _signUp() {
    return _$_signUpAsyncAction.run(() => super._signUp());
  }

  final _$_AddUserStoreActionController =
      ActionController(name: '_AddUserStore');

  @override
  void setName(String value) {
    final _$actionInfo = _$_AddUserStoreActionController.startAction(
        name: '_AddUserStore.setName');
    try {
      return super.setName(value);
    } finally {
      _$_AddUserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_AddUserStoreActionController.startAction(
        name: '_AddUserStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_AddUserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhoto(dynamic value) {
    final _$actionInfo = _$_AddUserStoreActionController.startAction(
        name: '_AddUserStore.setPhoto');
    try {
      return super.setPhoto(value);
    } finally {
      _$_AddUserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStartDate(DateTime value) {
    final _$actionInfo = _$_AddUserStoreActionController.startAction(
        name: '_AddUserStore.setStartDate');
    try {
      return super.setStartDate(value);
    } finally {
      _$_AddUserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserType(String? value) {
    final _$actionInfo = _$_AddUserStoreActionController.startAction(
        name: '_AddUserStore.setUserType');
    try {
      return super.setUserType(value);
    } finally {
      _$_AddUserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPost(String? value) {
    final _$actionInfo = _$_AddUserStoreActionController.startAction(
        name: '_AddUserStore.setPost');
    try {
      return super.setPost(value);
    } finally {
      _$_AddUserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
email: ${email},
photo: ${photo},
post: ${post},
roles: ${roles},
userType: ${userType},
startDate: ${startDate},
isLoading: ${isLoading},
error: ${error},
userCreated: ${userCreated},
userSavedForm: ${userSavedForm},
userTypeString: ${userTypeString},
nameValid: ${nameValid},
nameError: ${nameError},
emailValid: ${emailValid},
postError: ${postError},
isFormValid: ${isFormValid},
signupPressed: ${signupPressed},
showErrors: ${showErrors}
    ''';
  }
}
