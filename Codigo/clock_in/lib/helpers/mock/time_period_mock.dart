import 'package:clock_in/models/hours_management/time_period_model.dart';

final dayOne = <TimePeriod>[
  TimePeriod(
    startingTime: DateTime(2022, 3, 1, 8),
    endingTime: DateTime(2022, 3, 1, 12),
  ),
  TimePeriod(
    startingTime: DateTime(2022, 3, 1, 13),
    endingTime: DateTime(2022, 3, 1, 17),
  ),
];

final dayTwo = <TimePeriod>[
  TimePeriod(
    startingTime: DateTime(2022, 3, 2, 7, 30),
    endingTime: DateTime(2022, 3, 2, 11, 30),
  ),
  TimePeriod(
    startingTime: DateTime(2022, 3, 2, 13),
    endingTime: DateTime(2022, 3, 2, 18, 45),
  ),
];
