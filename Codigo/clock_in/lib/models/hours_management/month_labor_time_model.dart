import 'package:clock_in/helpers/extensions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:clock_in/models/auth/user_model.dart';
import 'package:clock_in/models/hours_management/labor_time_model.dart';

part 'month_labor_time_model.freezed.dart';
part 'month_labor_time_model.g.dart';

@freezed
class MonthLaborTime with _$MonthLaborTime {
  const MonthLaborTime._();
  factory MonthLaborTime({
    String? objectId,
    required User user,
    required int year,
    required int month,
    String? status,
    String? monthReference,
    @Default(<LaborTime>[]) List<LaborTime> laborTimeList,
  }) = _MonthLaborTime;

  List<LaborTime> createLaborTime() {
    int totalDays = daysInMonth(DateTime(year, month));
    return List<LaborTime>.generate(
      totalDays,
      (i) => LaborTime(
        date: DateTime(year, month, i + 1),
      ),
    );
  }

  List<LaborTime> generateMissingLaborTime() {
    int totalDays = daysInMonth(DateTime(year, month));
    List<int> daysToJump = laborTimeList.map((e) => e.dayOfMonth).toList();
    return List<LaborTime>.generate(
      totalDays,
      (i) {
        final index = i + 1;
        if (daysToJump.contains(index)) {
          return laborTimeList
              .firstWhere((element) => element.dayOfMonth == index);
        } else {
          return LaborTime(
            date: DateTime(year, month, index),
            monthLaborTimeId: objectId,
          );
        }
      },
    );
  }

  int daysInMonth(DateTime date) {
    var firstDayThisMonth = DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  LaborTime getLaborTimeByDay(int day) {
    return laborTimeList.firstWhere((element) => element.dayOfMonth == day);
  }

  factory MonthLaborTime.fromJson(Map<String, dynamic> json) =>
      _$MonthLaborTimeFromJson(json);

  // HL Total de Horas Lançadas
  double get totalHoursClocked {
    if (laborTimeList.isEmpty) {
      return 0;
    }

    return laborTimeList.fold(
      0,
      (previousValue, element) =>
          (previousValue + element.calculateTotalHours()).toPrecision(2),
    );
  }

  // TH Horas a trabalhar até 'hoje'
  double get getHoursToWork {
    if (laborTimeList.isEmpty) {
      return 0;
    }

    int dailyHours = user.scheduleHours;

    DateTime now = DateTime.now();
    DateTime monthLaborTimeDate = DateTime(year, month + 1, 0);

    DateTime dateToCompare =
        now.isBefore(monthLaborTimeDate) ? now : monthLaborTimeDate;

    double daysToWork = laborTimeList.fold(
        0,
        (previousValue, element) => (element.date.isBefore(dateToCompare) &&
                element.dayOfWeekType == TypeOfDay.businessDay)
            ? previousValue + 1
            : previousValue);

    return (dailyHours * daysToWork).toPrecision(2);
  }

  // SA Saldo Atual (HL -TH
  double get currentBalance {
    return totalHoursClocked - getHoursToWork;
  }

  // TM Horas a trabalhar no mês (TM)
  double get hoursToWorkThisMonth {
    if (laborTimeList.isEmpty) {
      return 0;
    }
    double totalBusinessDay = laborTimeList.fold(
        0,
        (previousValue, element) =>
            (element.dayOfWeekType == TypeOfDay.businessDay)
                ? previousValue + 1
                : previousValue);

    return totalBusinessDay * user.scheduleHours;
  }

  // SM Saldo do mẽs HL - TM
  double get monthBalance {
    return totalHoursClocked - hoursToWorkThisMonth;
  }
}
