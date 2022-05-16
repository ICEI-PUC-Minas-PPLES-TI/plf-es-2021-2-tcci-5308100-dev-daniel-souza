// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'time_period_model.freezed.dart';
// part 'time_period_model.g.dart';

// @freezed
// class TimePeriod with _$TimePeriod {
//   factory TimePeriod({
//     String? objectId,
//     String? laborTimeId,
//     DateTime? startingTime,
//     DateTime? endingTime,
//     @Default(false) bool isSelected,
//   }) = _TimePeriod;

//   factory TimePeriod.fromJson(Map<String, dynamic> json) =>
//       _$TimePeriodFromJson(json);
// }

import 'package:intl/intl.dart';
import 'package:clock_in/helpers/extensions.dart';

class TimePeriod {
  String? objectId;
  String? laborTimeId;
  DateTime? startingTime;
  DateTime? endingTime;
  bool isSelected = false;

  TimePeriod(
      {this.objectId,
      this.laborTimeId,
      this.startingTime,
      this.endingTime,
      this.isSelected = false});

  double getHoursWorked() {
    if (startingTime == null || endingTime == null) {
      return 0;
    }
    if (endingTime!.isAfter(startingTime!)) {
      return (endingTime!.difference(startingTime!).inMinutes / 60)
          .toPrecision(2);
    } else {
      return (startingTime!.difference(endingTime!).inMinutes / 60)
          .toPrecision(2);
    }
  }

  TimePeriod.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    if (json.containsKey('laborTimeId')) {
      laborTimeId = json['laborTimeId'];
    }
    if (json.containsKey('labor_time_id')) {
      final laborTimeIdFromJson = json['labor_time_id'];
      laborTimeId = laborTimeIdFromJson['objectId'];
    }
    if (json.containsKey('start')) {
      final start = json['start'];
      startingTime = DateTime.parse(start['iso']);
    }
    if (json.containsKey('startingTime')) {
      startingTime = DateTime.parse(json['startingTime']);
    }
    if (json.containsKey('end')) {
      final end = json['end'];
      endingTime = DateTime.parse(end['iso']);
    }
    if (json.containsKey('endingTime')) {
      endingTime = DateTime.parse(json['endingTime']);
    }
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['laborTimeId'] = laborTimeId;
    data['startingTime'] = startingTime.toString();
    data['endingTime'] = endingTime.toString();
    data['isSelected'] = isSelected;
    return data;
  }

  @override
  String toString() {
    return 'Entrada: ${startingTime != null ? DateFormat.Hm().format(startingTime!) : '-'} Saída: ${endingTime != null ? DateFormat.Hm().format(endingTime!) : '-'}';
  }
}
