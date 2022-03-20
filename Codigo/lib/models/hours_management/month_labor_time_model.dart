import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sglh/models/auth/user_model.dart';
import 'package:sglh/models/hours_management/labor_time_model.dart';

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
}
