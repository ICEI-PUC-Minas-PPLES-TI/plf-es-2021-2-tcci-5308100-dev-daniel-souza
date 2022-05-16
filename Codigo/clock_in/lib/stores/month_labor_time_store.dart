import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:clock_in/helpers/extensions.dart';
import 'package:clock_in/models/auth/user_model.dart';
import 'package:clock_in/models/hours_management/labor_time_model.dart';
import 'package:clock_in/models/hours_management/month_labor_time_model.dart';
import 'package:clock_in/models/hours_management/time_period_model.dart';
import 'package:clock_in/repositories/labor_time_repository.dart';
import 'package:clock_in/stores/auth_store.dart';

part 'month_labor_time_store.g.dart';

class MonthLaborTimeStore = _MonthLaborTimeStore with _$MonthLaborTimeStore;

abstract class _MonthLaborTimeStore with Store {
  static ObservableFuture<List<MonthLaborTime>> emptyResponse =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<MonthLaborTime>> fetchReposFuture = emptyResponse;

  @observable
  bool isLoading = false;

  @action
  Future<void> fetchData() async {
    isLoading = true;
    User user = GetIt.I<AuthStore>().user;
    operationError = null;
    if (user.objectId != null) {
      fetchReposFuture = ObservableFuture(
          LaborTimeRepository.getClockInDataFromUser(user)
              .then((value) => value));
    }
    isLoading = false;
  }

  @observable
  String monthReference = DateTime.now().getMonthReference();

  @observable
  int year = int.parse(DateTime.now().getMonthReference().split('/')[1]);

  @observable
  int month = int.parse(DateTime.now().getMonthReference().split('/')[0]);

  @action
  void setMonthReference(String value) => monthReference = value;

  @observable
  MonthLaborTime? currentMonthLaborTime;

  @action
  void setCurrentMonthLaborTime(List<MonthLaborTime>? list) {
    if (list != null && list.isNotEmpty) {
      currentMonthLaborTime = list.firstWhere((element) =>
          element.monthReference == monthReference ||
          (element.month == month && element.year == year));
    }
    if (currentMonthLaborTime != null) {
      setCurrentLaborTime(currentMonthLaborTime!);
    }
  }

  @action
  void setMonthLaborTime(MonthLaborTime mlt) {
    currentMonthLaborTime = mlt;
    setCurrentLaborTime(currentMonthLaborTime!);
    print(currentMonthLaborTime);
  }

  @computed
  get weekDayName {
    if (currentLaborTime == null) {
      return "";
    }
    Map<String, dynamic>? map =
        LaborTime.dayOfWeekMap[currentLaborTime!.date.weekday];

    return map!['name']!;
  }

  @observable
  LaborTime? currentLaborTime;

  @action
  void setCurrentLaborTime(MonthLaborTime monthLaborTime) {
    currentLaborTime = monthLaborTime.getLaborTimeByDay(chosenDay);
  }

  @observable
  int chosenDay = DateTime.now().day;

  @action
  void setChosenDay(int value) {
    chosenDay = value;
    if (currentMonthLaborTime != null) {
      setCurrentLaborTime(currentMonthLaborTime!);
    }
    print('chosenDay: $chosenDay');
  }

  @action
  void updateTimePeriodStartingTime(DateTime time, TimePeriod timePeriod) {
    timePeriod.startingTime = time;
    refreshLaborTime();
  }

  @action
  void updateTimePeriodEndingTime(DateTime time, TimePeriod timePeriod) {
    timePeriod.endingTime = time;
    refreshLaborTime();
  }

  @action
  void removeTimePeriod(TimePeriod timePeriod) {
    currentLaborTime!.clockInList.remove(timePeriod);
    refreshLaborTime();
  }

  @action
  void addTimePeriod(TimePeriod timePeriod) {
    currentLaborTime?.clockInList.add(timePeriod);
    refreshLaborTime();
  }

  @action
  Future<void> deleteTimePeriod(TimePeriod timePeriod) async {
    isLoading = true;
    operationError = null;
    String? result = await LaborTimeRepository.deleteTimePeriod(timePeriod);
    if (result != null) {
      throw result;
    } else {
      await fetchData();
    }
    isLoading = false;
  }

  @action
  void refreshLaborTime() {
    currentLaborTime = currentLaborTime;
  }

  @observable
  String? operationError;

  @action
  void removeStartingTime(TimePeriod timePeriod) {
    timePeriod.startingTime = null;
    refreshLaborTime();
  }

  @action
  void removeEndingTime(TimePeriod timePeriod) {
    timePeriod.endingTime = null;
    refreshLaborTime();
  }

  @action
  Future<bool> saveData() async {
    isLoading = true;
    if (fetchReposFuture.value != null) {
      LaborTimeRepository.saveClockInData(fetchReposFuture.value!);
    }
    await fetchData();
    isLoading = false;
    return true;
  }

  // HL Total de Horas Lançadas
  @computed
  double get totalHoursClocked {
    if (fetchReposFuture.value == null) {
      return 0;
    }
    MonthLaborTime? thisMonthLaborTime = getCurrentMonthLaborTime();

    if (thisMonthLaborTime.laborTimeList.isEmpty) {
      return 0;
    }

    return thisMonthLaborTime.laborTimeList.fold(
      0,
      (previousValue, element) =>
          (previousValue + element.calculateTotalHours()).toPrecision(2),
    );
  }

  // TH Horas a trabalhar até 'hoje'
  @computed
  double get getHoursToWork {
    if (fetchReposFuture.value == null) {
      return 0;
    }
    User user = GetIt.I<AuthStore>().user;
    int dailyHours = user.scheduleHours;
    if (fetchReposFuture.value == null) {
      return 0;
    }
    MonthLaborTime? thisMonthLaborTime = getCurrentMonthLaborTime();
    if (thisMonthLaborTime.laborTimeList.isEmpty) {
      return 0;
    }

    DateTime now = DateTime.now();
    double daysToWork = thisMonthLaborTime.laborTimeList.fold(
        0,
        (previousValue, element) => (element.date.isBefore(now) &&
                element.dayOfWeekType == TypeOfDay.businessDay)
            ? previousValue + 1
            : previousValue);

    return (dailyHours * daysToWork).toPrecision(2);
  }

  // SA Saldo Atual (HL -TH
  @computed
  double get currentBalance {
    return totalHoursClocked - getHoursToWork;
  }

  // TM Horas a trabalhar no mês (TM)
  @computed
  double get hoursToWorkThisMonth {
    if (fetchReposFuture.value == null) {
      return 0;
    }
    MonthLaborTime thisMonthLaborTime = getCurrentMonthLaborTime();

    if (thisMonthLaborTime.laborTimeList.isEmpty) {
      return 0;
    }
    double totalBusinessDay = thisMonthLaborTime.laborTimeList.fold(
        0,
        (previousValue, element) =>
            (element.dayOfWeekType == TypeOfDay.businessDay)
                ? previousValue + 1
                : previousValue);

    return totalBusinessDay * GetIt.I<AuthStore>().user.scheduleHours;
  }

  // SM Saldo do mẽs HL - TM
  @computed
  double get monthBalance {
    return totalHoursClocked - hoursToWorkThisMonth;
  }

  // BH Banco de Horas
  @computed
  double get compensatoryTimeOff {
    if (fetchReposFuture.value == null) {
      return 0;
    }

    if (fetchReposFuture.value!.length == 1) {
      return 0;
    }

    // At this point, it should have at least 2 elements in the array
    // Sort the list by int YEAR and MONTH
    fetchReposFuture.value!.sort((a, b) => a.year.compareTo(b.year) == 0
        ? a.month.compareTo(b.month)
        : a.year.compareTo(b.year));

    // return currentBalance from penultimate element
    return fetchReposFuture
        .value![fetchReposFuture.value!.length - 2].currentBalance
        .toPrecision(2);
  }

  MonthLaborTime getCurrentMonthLaborTime() {
    DateTime now = DateTime.now();
    MonthLaborTime thisMonthLaborTime = fetchReposFuture.value!.firstWhere(
      (element) => element.year == now.year && element.month == now.month,
      orElse: _createNewMonthLaborTime,
    );
    return thisMonthLaborTime;
  }

  MonthLaborTime getMonthLaborTimeByDateTime(DateTime now) {
    MonthLaborTime thisMonthLaborTime = fetchReposFuture.value!.firstWhere(
      (element) => element.year == now.year && element.month == now.month,
      orElse: () => _createMonthLaborTimeByDate(now),
    );
    return thisMonthLaborTime;
  }

  @action
  Future<void> sendToApproval(MonthLaborTime monthLaborTime) async {
    isLoading = true;
    operationError = null;
    await LaborTimeRepository.requestApproval(monthLaborTime);
    fetchData();
    isLoading = false;
  }

  @computed
  DateTime? get lastClockingEnd {
    if (currentLaborTime == null) {
      return null;
    }
    if (currentLaborTime!.clockInList.isEmpty) {
      return null;
    }
    return currentLaborTime?.clockInList.last.endingTime;
  }

  @computed
  DateTime? get penultimateClockingEnd {
    if (currentLaborTime == null) {
      return null;
    }
    if (currentLaborTime!.clockInList.isEmpty) {
      return null;
    }
    int size = currentLaborTime!.clockInList.length;
    if (size == 1) {
      return null;
    }
    return currentLaborTime!.clockInList[size - 1].endingTime;
  }

  @computed
  DateTime? get lastClockInStart {
    if (currentLaborTime == null) {
      return null;
    }
    if (currentLaborTime!.clockInList.isEmpty) {
      return null;
    }
    return currentLaborTime?.clockInList.last.startingTime;
  }

  @action
  Future<void> punchClock(DateTime dateTime) async {
    // obtêm o laborTime do dia
    MonthLaborTime monthLaborTime = getMonthLaborTimeByDateTime(dateTime);
    LaborTime laborTime = monthLaborTime.getLaborTimeByDay(dateTime.day);

    if (laborTime.clockInList.isNotEmpty) {
      // Atualiza o último registro de ponto sendo uma entrada ou saída, dependendo do histórico do dia
      TimePeriod lastTimePeriod = laborTime.clockInList.last;
      if (lastTimePeriod.endingTime == null) {
        updateTimePeriodEndingTime(dateTime, lastTimePeriod);
      } else {
        // criar novo time period
        TimePeriod timePeriod = TimePeriod(
          laborTimeId: laborTime.objectId,
          startingTime: dateTime,
          endingTime: null,
        );
        laborTime.clockInList.add(timePeriod);
      }
    } else {
      // criar novo time period
      TimePeriod timePeriod = TimePeriod(
        laborTimeId: laborTime.objectId,
        startingTime: dateTime,
        endingTime: null,
      );
      laborTime.clockInList.add(timePeriod);
    }

    await LaborTimeRepository.monthLaborTimeToParse(monthLaborTime);
    refreshLaborTime();
  }

  @computed
  bool get initialized => !isLoading;

  MonthLaborTime _createNewMonthLaborTime() {
    final now = DateTime.now();
    User user = GetIt.I<AuthStore>().user;
    MonthLaborTime initialMonthLaborTime = MonthLaborTime(
      user: user,
      year: now.year,
      month: now.month,
      status: "Em lançamento",
      monthReference: now.getMonthReference(),
    );
    final initiatedMonthLaborTime = initialMonthLaborTime.copyWith(
      laborTimeList: initialMonthLaborTime.createLaborTime(),
    );
    fetchReposFuture.value?.add(initiatedMonthLaborTime);
    return initiatedMonthLaborTime;
  }

  MonthLaborTime _createMonthLaborTimeByDate(DateTime dateTime) {
    User user = GetIt.I<AuthStore>().user;
    MonthLaborTime initialMonthLaborTime = MonthLaborTime(
      user: user,
      year: dateTime.year,
      month: dateTime.month,
      status: "Em lançamento",
      monthReference: dateTime.getMonthReference(),
    );
    final initiatedMonthLaborTime = initialMonthLaborTime.copyWith(
      laborTimeList: initialMonthLaborTime.createLaborTime(),
    );
    fetchReposFuture.value?.add(initiatedMonthLaborTime);
    return initiatedMonthLaborTime;
  }
}
