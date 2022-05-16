// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignupStore on _SignupStore, Store {
  Computed<bool>? _$nameIsStringComputed;

  @override
  bool get nameIsString =>
      (_$nameIsStringComputed ??= Computed<bool>(() => super.nameIsString,
              name: '_SignupStore.nameIsString'))
          .value;
  Computed<bool>? _$emailIsStringComputed;

  @override
  bool get emailIsString =>
      (_$emailIsStringComputed ??= Computed<bool>(() => super.emailIsString,
              name: '_SignupStore.emailIsString'))
          .value;
  Computed<bool>? _$password1IsStringComputed;

  @override
  bool get password1IsString => (_$password1IsStringComputed ??= Computed<bool>(
          () => super.password1IsString,
          name: '_SignupStore.password1IsString'))
      .value;
  Computed<bool>? _$password2IsStringComputed;

  @override
  bool get password2IsString => (_$password2IsStringComputed ??= Computed<bool>(
          () => super.password2IsString,
          name: '_SignupStore.password2IsString'))
      .value;
  Computed<bool>? _$nameValidComputed;

  @override
  bool get nameValid => (_$nameValidComputed ??=
          Computed<bool>(() => super.nameValid, name: '_SignupStore.nameValid'))
      .value;
  Computed<dynamic>? _$nameErrorComputed;

  @override
  dynamic get nameError =>
      (_$nameErrorComputed ??= Computed<dynamic>(() => super.nameError,
              name: '_SignupStore.nameError'))
          .value;
  Computed<bool>? _$emailValidComputed;

  @override
  bool get emailValid =>
      (_$emailValidComputed ??= Computed<bool>(() => super.emailValid,
              name: '_SignupStore.emailValid'))
          .value;
  Computed<bool>? _$password1ValidComputed;

  @override
  bool get password1Valid =>
      (_$password1ValidComputed ??= Computed<bool>(() => super.password1Valid,
              name: '_SignupStore.password1Valid'))
          .value;
  Computed<dynamic>? _$password1ErrorComputed;

  @override
  dynamic get password1Error => (_$password1ErrorComputed ??= Computed<dynamic>(
          () => super.password1Error,
          name: '_SignupStore.password1Error'))
      .value;
  Computed<bool>? _$password2ValidComputed;

  @override
  bool get password2Valid =>
      (_$password2ValidComputed ??= Computed<bool>(() => super.password2Valid,
              name: '_SignupStore.password2Valid'))
          .value;
  Computed<dynamic>? _$password2ErrorComputed;

  @override
  dynamic get password2Error => (_$password2ErrorComputed ??= Computed<dynamic>(
          () => super.password2Error,
          name: '_SignupStore.password2Error'))
      .value;
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_SignupStore.isFormValid'))
          .value;
  Computed<dynamic>? _$signupPressedComputed;

  @override
  dynamic get signupPressed =>
      (_$signupPressedComputed ??= Computed<dynamic>(() => super.signupPressed,
              name: '_SignupStore.signupPressed'))
          .value;
  Computed<bool>? _$userCreatedComputed;

  @override
  bool get userCreated =>
      (_$userCreatedComputed ??= Computed<bool>(() => super.userCreated,
              name: '_SignupStore.userCreated'))
          .value;

  late final _$nameAtom = Atom(name: '_SignupStore.name', context: context);

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$emailAtom = Atom(name: '_SignupStore.email', context: context);

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$password1Atom =
      Atom(name: '_SignupStore.password1', context: context);

  @override
  String? get password1 {
    _$password1Atom.reportRead();
    return super.password1;
  }

  @override
  set password1(String? value) {
    _$password1Atom.reportWrite(value, super.password1, () {
      super.password1 = value;
    });
  }

  late final _$password2Atom =
      Atom(name: '_SignupStore.password2', context: context);

  @override
  String? get password2 {
    _$password2Atom.reportRead();
    return super.password2;
  }

  @override
  set password2(String? value) {
    _$password2Atom.reportWrite(value, super.password2, () {
      super.password2 = value;
    });
  }

  late final _$showPassword1Atom =
      Atom(name: '_SignupStore.showPassword1', context: context);

  @override
  bool get showPassword1 {
    _$showPassword1Atom.reportRead();
    return super.showPassword1;
  }

  @override
  set showPassword1(bool value) {
    _$showPassword1Atom.reportWrite(value, super.showPassword1, () {
      super.showPassword1 = value;
    });
  }

  late final _$showPassword2Atom =
      Atom(name: '_SignupStore.showPassword2', context: context);

  @override
  bool get showPassword2 {
    _$showPassword2Atom.reportRead();
    return super.showPassword2;
  }

  @override
  set showPassword2(bool value) {
    _$showPassword2Atom.reportWrite(value, super.showPassword2, () {
      super.showPassword2 = value;
    });
  }

  late final _$errorAtom = Atom(name: '_SignupStore.error', context: context);

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

  late final _$loadingAtom =
      Atom(name: '_SignupStore.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$userAtom = Atom(name: '_SignupStore.user', context: context);

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$_signUpAsyncAction =
      AsyncAction('_SignupStore._signUp', context: context);

  @override
  Future<void> _signUp() {
    return _$_signUpAsyncAction.run(() => super._signUp());
  }

  late final _$_SignupStoreActionController =
      ActionController(name: '_SignupStore', context: context);

  @override
  void setName(String value) {
    final _$actionInfo = _$_SignupStoreActionController.startAction(
        name: '_SignupStore.setName');
    try {
      return super.setName(value);
    } finally {
      _$_SignupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_SignupStoreActionController.startAction(
        name: '_SignupStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_SignupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword1(String value) {
    final _$actionInfo = _$_SignupStoreActionController.startAction(
        name: '_SignupStore.setPassword1');
    try {
      return super.setPassword1(value);
    } finally {
      _$_SignupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword2(String value) {
    final _$actionInfo = _$_SignupStoreActionController.startAction(
        name: '_SignupStore.setPassword2');
    try {
      return super.setPassword2(value);
    } finally {
      _$_SignupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void showHidePassword1() {
    final _$actionInfo = _$_SignupStoreActionController.startAction(
        name: '_SignupStore.showHidePassword1');
    try {
      return super.showHidePassword1();
    } finally {
      _$_SignupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void showHidePassword2() {
    final _$actionInfo = _$_SignupStoreActionController.startAction(
        name: '_SignupStore.showHidePassword2');
    try {
      return super.showHidePassword2();
    } finally {
      _$_SignupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
email: ${email},
password1: ${password1},
password2: ${password2},
showPassword1: ${showPassword1},
showPassword2: ${showPassword2},
error: ${error},
loading: ${loading},
user: ${user},
nameIsString: ${nameIsString},
emailIsString: ${emailIsString},
password1IsString: ${password1IsString},
password2IsString: ${password2IsString},
nameValid: ${nameValid},
nameError: ${nameError},
emailValid: ${emailValid},
password1Valid: ${password1Valid},
password1Error: ${password1Error},
password2Valid: ${password2Valid},
password2Error: ${password2Error},
isFormValid: ${isFormValid},
signupPressed: ${signupPressed},
userCreated: ${userCreated}
    ''';
  }
}
