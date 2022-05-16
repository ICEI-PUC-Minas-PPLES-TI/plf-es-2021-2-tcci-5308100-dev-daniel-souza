import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:clock_in/models/hours_management/time_period_model.dart';

class ScheduleClockIn {
  DateTime timeToClockIn;
  TimePeriod? relatedTimePeriod;
  ScheduleClockIn(this.timeToClockIn, {this.relatedTimePeriod});

  @override
  String toString() {
    if (relatedTimePeriod != null) {
      return "Marcar saída: ${DateFormat.d().format(timeToClockIn.toLocal())}";
    }
    return "Marcar entrada: ${DateFormat.yMMMMEEEEd('pt_BR').format(timeToClockIn.toLocal())}";
  }

  Map<String, String> toJson() {
    return {
      "clockInDay": timeToClockIn.day.toString(),
      "formattedHour": DateFormat.Hm('pt_BR').format(timeToClockIn),
      "formattedDate": DateFormat.yMMMMEEEEd('pt_BR').format(timeToClockIn),
      "timeToClockIn": timeToClockIn.toIso8601String(),
      "relatedTimePeriod": json.encode(relatedTimePeriod)
    };
  }
}
