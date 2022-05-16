// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'month_labor_time_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MonthLaborTimeStore on _MonthLaborTimeStore, Store {
  Computed<dynamic>? _$weekDayNameComputed;

  @override
  dynamic get weekDayName =>
      (_$weekDayNameComputed ??= Computed<dynamic>(() => super.weekDayName,
              name: '_MonthLaborTimeStore.weekDayName'))
          .value;
  Computed<double>? _$totalHoursClockedComputed;

  @override
  double get totalHoursClocked => (_$totalHoursClockedComputed ??=
          Computed<double>(() => super.totalHoursClocked,
              name: '_MonthLaborTimeStore.totalHoursClocked'))
      .value;
  Computed<double>? _$getHoursToWorkComputed;

  @override
  double get getHoursToWork =>
      (_$getHoursToWorkComputed ??= Computed<double>(() => super.getHoursToWork,
              name: '_MonthLaborTimeStore.getHoursToWork'))
          .value;
  Computed<double>? _$currentBalanceComputed;

  @override
  double get currentBalance =>
      (_$currentBalanceComputed ??= Computed<double>(() => super.currentBalance,
              name: '_MonthLaborTimeStore.currentBalance'))
          .value;
  Computed<double>? _$hoursToWorkThisMonthComputed;

  @override
  double get hoursToWorkThisMonth => (_$hoursToWorkThisMonthComputed ??=
          Computed<double>(() => super.hoursToWorkThisMonth,
              name: '_MonthLaborTimeStore.hoursToWorkThisMonth'))
      .value;
  Computed<double>? _$monthBalanceComputed;

  @override
  double get monthBalance =>
      (_$monthBalanceComputed ??= Computed<double>(() => super.monthBalance,
              name: '_MonthLaborTimeStore.monthBalance'))
          .value;
  Computed<double>? _$compensatoryTimeOffComputed;

  @override
  double get compensatoryTimeOff => (_$compensatoryTimeOffComputed ??=
          Computed<double>(() => super.compensatoryTimeOff,
              name: '_MonthLaborTimeStore.compensatoryTimeOff'))
      .value;
  Computed<DateTime?>? _$lastClockingEndComputed;

  @override
  DateTime? get lastClockingEnd => (_$lastClockingEndComputed ??=
          Computed<DateTime?>(() => super.lastClockingEnd,
              name: '_MonthLaborTimeStore.lastClockingEnd'))
      .value;
  Computed<DateTime?>? _$penultimateClockingEndComputed;

  @override
  DateTime? get penultimateClockingEnd => (_$penultimateClockingEndComputed ??=
          Computed<DateTime?>(() => super.penultimateClockingEnd,
              name: '_MonthLaborTimeStore.penultimateClockingEnd'))
      .value;
  Computed<DateTime?>? _$lastClockInStartComputed;

  @override
  DateTime? get lastClockInStart => (_$lastClockInStartComputed ??=
          Computed<DateTime?>(() => super.lastClockInStart,
              name: '_MonthLaborTimeStore.lastClockInStart'))
      .value;
  Computed<bool>? _$initializedComputed;

  @override
  bool get initialized =>
      (_$initializedComputed ??= Computed<bool>(() => super.initialized,
              name: '_MonthLaborTimeStore.initialized'))
          .value;

  late final _$fetchReposFutureAtom =
      Atom(name: '_MonthLaborTimeStore.fetchReposFuture', context: context);

  @override
  ObservableFuture<List<MonthLaborTime>> get fetchReposFuture {
    _$fetchReposFutureAtom.reportRead();
    return super.fetchReposFuture;
  }

  @override
  set fetchReposFuture(ObservableFuture<List<MonthLaborTime>> value) {
    _$fetchReposFutureAtom.reportWrite(value, super.fetchReposFuture, () {
      super.fetchReposFuture = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_MonthLaborTimeStore.isLoading', context: context);

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

  late final _$monthReferenceAtom =
      Atom(name: '_MonthLaborTimeStore.monthReference', context: context);

  @override
  String get monthReference {
    _$monthReferenceAtom.reportRead();
    return super.monthReference;
  }

  @override
  set monthReference(String value) {
    _$monthReferenceAtom.reportWrite(value, super.monthReference, () {
      super.monthReference = value;
    });
  }

  late final _$yearAtom =
      Atom(name: '_MonthLaborTimeStore.year', context: context);

  @override
  int get year {
    _$yearAtom.reportRead();
    return super.year;
  }

  @override
  set year(int value) {
    _$yearAtom.reportWrite(value, super.year, () {
      super.year = value;
    });
  }

  late final _$monthAtom =
      Atom(name: '_MonthLaborTimeStore.month', context: context);

  @override
  int get month {
    _$monthAtom.reportRead();
    return super.month;
  }

  @override
  set month(int value) {
    _$monthAtom.reportWrite(value, super.month, () {
      super.month = value;
    });
  }

  late final _$currentMonthLaborTimeAtom = Atom(
      name: '_MonthLaborTimeStore.currentMonthLaborTime', context: context);

  @override
  MonthLaborTime? get currentMonthLaborTime {
    _$currentMonthLaborTimeAtom.reportRead();
    return super.currentMonthLaborTime;
  }

  @override
  set currentMonthLaborTime(MonthLaborTime? value) {
    _$currentMonthLaborTimeAtom.reportWrite(value, super.currentMonthLaborTime,
        () {
      super.currentMonthLaborTime = value;
    });
  }

  late final _$currentLaborTimeAtom =
      Atom(name: '_MonthLaborTimeStore.currentLaborTime', context: context);

  @override
  LaborTime? get currentLaborTime {
    _$currentLaborTimeAtom.reportRead();
    return super.currentLaborTime;
  }

  @override
  set currentLaborTime(LaborTime? value) {
    _$currentLaborTimeAtom.reportWrite(value, super.currentLaborTime, () {
      super.currentLaborTime = value;
    });
  }

  late final _$chosenDayAtom =
      Atom(name: '_MonthLaborTimeStore.chosenDay', context: context);

  @override
  int get chosenDay {
    _$chosenDayAtom.reportRead();
    return super.chosenDay;
  }

  @override
  set chosenDay(int value) {
    _$chosenDayAtom.reportWrite(value, super.chosenDay, () {
      super.chosenDay = value;
    });
  }

  late final _$operationErrorAtom =
      Atom(name: '_MonthLaborTimeStore.operationError', context: context);

  @override
  String? get operationError {
    _$operationErrorAtom.reportRead();
    return super.operationError;
  }

  @override
  set operationError(String? value) {
    _$operationErrorAtom.reportWrite(value, super.operationError, () {
      super.operationError = value;
    });
  }

  late final _$fetchDataAsyncAction =
      AsyncAction('_MonthLaborTimeStore.fetchData', context: context);

  @override
  Future<void> fetchData() {
    return _$fetchDataAsyncAction.run(() => super.fetchData());
  }

  late final _$deleteTimePeriodAsyncAction =
      AsyncAction('_MonthLaborTimeStore.deleteTimePeriod', context: context);

  @override
  Future<void> deleteTimePeriod(TimePeriod timePeriod) {
    return _$deleteTimePeriodAsyncAction
        .run(() => super.deleteTimePeriod(timePeriod));
  }

  late final _$saveDataAsyncAction =
      AsyncAction('_MonthLaborTimeStore.saveData', context: context);

  @override
  Future<bool> saveData() {
    return _$saveDataAsyncAction.run(() => super.saveData());
  }

  late final _$sendToApprovalAsyncAction =
      AsyncAction('_MonthLaborTimeStore.sendToApproval', context: context);

  @override
  Future<void> sendToApproval(MonthLaborTime monthLaborTime) {
    return _$sendToApprovalAsyncAction
        .run(() => super.sendToApproval(monthLaborTime));
  }

  late final _$punchClockAsyncAction =
      AsyncAction('_MonthLaborTimeStore.punchClock', context: context);

  @override
  Future<void> punchClock(DateTime dateTime) {
    return _$punchClockAsyncAction.run(() => super.punchClock(dateTime));
  }

  late final _$_MonthLaborTimeStoreActionController =
      ActionController(name: '_MonthLaborTimeStore', context: context);

  @override
  void setMonthReference(String value) {
    final _$actionInfo = _$_MonthLaborTimeStoreActionController.startAction(
        name: '_MonthLaborTimeStore.setMonthReference');
    try {
      return super.setMonthReference(value);
    } finally {
      _$_MonthLaborTimeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentMonthLaborTime(List<MonthLaborTime>? list) {
    final _$actionInfo = _$_MonthLaborTimeStoreActionController.startAction(
        name: '_MonthLaborTimeStore.setCurrentMonthLaborTime');
    try {
      return super.setCurrentMonthLaborTime(list);
    } finally {
      _$_MonthLaborTimeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMonthLaborTime(MonthLaborTime mlt) {
    final _$actionInfo = _$_MonthLaborTimeStoreActionController.startAction(
        name: '_MonthLaborTimeStore.setMonthLaborTime');
    try {
      return super.setMonthLaborTime(mlt);
    } finally {
      _$_MonthLaborTimeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentLaborTime(MonthLaborTime monthLaborTime) {
    final _$actionInfo = _$_MonthLaborTimeStoreActionController.startAction(
        name: '_MonthLaborTimeStore.setCurrentLaborTime');
    try {
      return super.setCurrentLaborTime(monthLaborTime);
    } finally {
      _$_MonthLaborTimeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setChosenDay(int value) {
    final _$actionInfo = _$_MonthLaborTimeStoreActionController.startAction(
        name: '_MonthLaborTimeStore.setChosenDay');
    try {
      return super.setChosenDay(value);
    } finally {
      _$_MonthLaborTimeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateTimePeriodStartingTime(DateTime time, TimePeriod timePeriod) {
    final _$actionInfo = _$_MonthLaborTimeStoreActionController.startAction(
        name: '_MonthLaborTimeStore.updateTimePeriodStartingTime');
    try {
      return super.updateTimePeriodStartingTime(time, timePeriod);
    } finally {
      _$_MonthLaborTimeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateTimePeriodEndingTime(DateTime time, TimePeriod timePeriod) {
    final _$actionInfo = _$_MonthLaborTimeStoreActionController.startAction(
        name: '_MonthLaborTimeStore.updateTimePeriodEndingTime');
    try {
      return super.updateTimePeriodEndingTime(time, timePeriod);
    } finally {
      _$_MonthLaborTimeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTimePeriod(TimePeriod timePeriod) {
    final _$actionInfo = _$_MonthLaborTimeStoreActionController.startAction(
        name: '_MonthLaborTimeStore.removeTimePeriod');
    try {
      return super.removeTimePeriod(timePeriod);
    } finally {
      _$_MonthLaborTimeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addTimePeriod(TimePeriod timePeriod) {
    final _$actionInfo = _$_MonthLaborTimeStoreActionController.startAction(
        name: '_MonthLaborTimeStore.addTimePeriod');
    try {
      return super.addTimePeriod(timePeriod);
    } finally {
      _$_MonthLaborTimeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void refreshLaborTime() {
    final _$actionInfo = _$_MonthLaborTimeStoreActionController.startAction(
        name: '_MonthLaborTimeStore.refreshLaborTime');
    try {
      return super.refreshLaborTime();
    } finally {
      _$_MonthLaborTimeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeStartingTime(TimePeriod timePeriod) {
    final _$actionInfo = _$_MonthLaborTimeStoreActionController.startAction(
        name: '_MonthLaborTimeStore.removeStartingTime');
    try {
      return super.removeStartingTime(timePeriod);
    } finally {
      _$_MonthLaborTimeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeEndingTime(TimePeriod timePeriod) {
    final _$actionInfo = _$_MonthLaborTimeStoreActionController.startAction(
        name: '_MonthLaborTimeStore.removeEndingTime');
    try {
      return super.removeEndingTime(timePeriod);
    } finally {
      _$_MonthLaborTimeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchReposFuture: ${fetchReposFuture},
isLoading: ${isLoading},
monthReference: ${monthReference},
year: ${year},
month: ${month},
currentMonthLaborTime: ${currentMonthLaborTime},
currentLaborTime: ${currentLaborTime},
chosenDay: ${chosenDay},
operationError: ${operationError},
weekDayName: ${weekDayName},
totalHoursClocked: ${totalHoursClocked},
getHoursToWork: ${getHoursToWork},
currentBalance: ${currentBalance},
hoursToWorkThisMonth: ${hoursToWorkThisMonth},
monthBalance: ${monthBalance},
compensatoryTimeOff: ${compensatoryTimeOff},
lastClockingEnd: ${lastClockingEnd},
penultimateClockingEnd: ${penultimateClockingEnd},
lastClockInStart: ${lastClockInStart},
initialized: ${initialized}
    ''';
  }
}
