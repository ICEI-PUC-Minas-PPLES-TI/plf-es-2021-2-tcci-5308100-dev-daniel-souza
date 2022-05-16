// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppSettingsStore on _AppSettingsStore, Store {
  Computed<bool>? _$isWorkPlaceSetComputed;

  @override
  bool get isWorkPlaceSet =>
      (_$isWorkPlaceSetComputed ??= Computed<bool>(() => super.isWorkPlaceSet,
              name: '_AppSettingsStore.isWorkPlaceSet'))
          .value;

  late final _$geolocationEnabledAtom =
      Atom(name: '_AppSettingsStore.geolocationEnabled', context: context);

  @override
  bool get geolocationEnabled {
    _$geolocationEnabledAtom.reportRead();
    return super.geolocationEnabled;
  }

  @override
  set geolocationEnabled(bool value) {
    _$geolocationEnabledAtom.reportWrite(value, super.geolocationEnabled, () {
      super.geolocationEnabled = value;
    });
  }

  late final _$notificationsEnabledAtom =
      Atom(name: '_AppSettingsStore.notificationsEnabled', context: context);

  @override
  bool get notificationsEnabled {
    _$notificationsEnabledAtom.reportRead();
    return super.notificationsEnabled;
  }

  @override
  set notificationsEnabled(bool value) {
    _$notificationsEnabledAtom.reportWrite(value, super.notificationsEnabled,
        () {
      super.notificationsEnabled = value;
    });
  }

  late final _$remindersEnabledAtom =
      Atom(name: '_AppSettingsStore.remindersEnabled', context: context);

  @override
  bool get remindersEnabled {
    _$remindersEnabledAtom.reportRead();
    return super.remindersEnabled;
  }

  @override
  set remindersEnabled(bool value) {
    _$remindersEnabledAtom.reportWrite(value, super.remindersEnabled, () {
      super.remindersEnabled = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AppSettingsStore.isLoading', context: context);

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

  late final _$workPlaceAtom =
      Atom(name: '_AppSettingsStore.workPlace', context: context);

  @override
  WorkPlace? get workPlace {
    _$workPlaceAtom.reportRead();
    return super.workPlace;
  }

  @override
  set workPlace(WorkPlace? value) {
    _$workPlaceAtom.reportWrite(value, super.workPlace, () {
      super.workPlace = value;
    });
  }

  late final _$searchResultAtom =
      Atom(name: '_AppSettingsStore.searchResult', context: context);

  @override
  String? get searchResult {
    _$searchResultAtom.reportRead();
    return super.searchResult;
  }

  @override
  set searchResult(String? value) {
    _$searchResultAtom.reportWrite(value, super.searchResult, () {
      super.searchResult = value;
    });
  }

  late final _$getWorkPlaceLocationAsyncAction =
      AsyncAction('_AppSettingsStore.getWorkPlaceLocation', context: context);

  @override
  Future<void> getWorkPlaceLocation() {
    return _$getWorkPlaceLocationAsyncAction
        .run(() => super.getWorkPlaceLocation());
  }

  late final _$setWorkPlaceAsyncAction =
      AsyncAction('_AppSettingsStore.setWorkPlace', context: context);

  @override
  Future<void> setWorkPlace(double latitude, double longitude, String address) {
    return _$setWorkPlaceAsyncAction
        .run(() => super.setWorkPlace(latitude, longitude, address));
  }

  late final _$deleteWorkPlaceAsyncAction =
      AsyncAction('_AppSettingsStore.deleteWorkPlace', context: context);

  @override
  Future<void> deleteWorkPlace() {
    return _$deleteWorkPlaceAsyncAction.run(() => super.deleteWorkPlace());
  }

  late final _$_AppSettingsStoreActionController =
      ActionController(name: '_AppSettingsStore', context: context);

  @override
  void setGeolocationEnabled(bool value) {
    final _$actionInfo = _$_AppSettingsStoreActionController.startAction(
        name: '_AppSettingsStore.setGeolocationEnabled');
    try {
      return super.setGeolocationEnabled(value);
    } finally {
      _$_AppSettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNotificationsEnabled(bool value) {
    final _$actionInfo = _$_AppSettingsStoreActionController.startAction(
        name: '_AppSettingsStore.setNotificationsEnabled');
    try {
      return super.setNotificationsEnabled(value);
    } finally {
      _$_AppSettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRemindersEnabled(bool value) {
    final _$actionInfo = _$_AppSettingsStoreActionController.startAction(
        name: '_AppSettingsStore.setRemindersEnabled');
    try {
      return super.setRemindersEnabled(value);
    } finally {
      _$_AppSettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsLoading(bool value) {
    final _$actionInfo = _$_AppSettingsStoreActionController.startAction(
        name: '_AppSettingsStore.setIsLoading');
    try {
      return super.setIsLoading(value);
    } finally {
      _$_AppSettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void search(String value) {
    final _$actionInfo = _$_AppSettingsStoreActionController.startAction(
        name: '_AppSettingsStore.search');
    try {
      return super.search(value);
    } finally {
      _$_AppSettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearSearch() {
    final _$actionInfo = _$_AppSettingsStoreActionController.startAction(
        name: '_AppSettingsStore.clearSearch');
    try {
      return super.clearSearch();
    } finally {
      _$_AppSettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
geolocationEnabled: ${geolocationEnabled},
notificationsEnabled: ${notificationsEnabled},
remindersEnabled: ${remindersEnabled},
isLoading: ${isLoading},
workPlace: ${workPlace},
searchResult: ${searchResult},
isWorkPlaceSet: ${isWorkPlaceSet}
    ''';
  }
}
