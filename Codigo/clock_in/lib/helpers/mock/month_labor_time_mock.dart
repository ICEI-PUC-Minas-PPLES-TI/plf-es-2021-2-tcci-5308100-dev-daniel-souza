import 'package:clock_in/models/auth/user_model.dart';
import 'package:clock_in/models/hours_management/labor_time_model.dart';
import 'package:clock_in/models/hours_management/month_labor_time_model.dart';

import 'labor_time_mock.dart';

Future<List<MonthLaborTime>> getData() async {
  final user = User.fromJson({
    "className": "_User",
    "objectId": "pL74mEhak4",
    "createdAt": "2022-02-22T20:29:23.157Z",
    "updatedAt": "2022-02-27T22:17:03.096Z",
    "username": "daniellyncon@gmail.com",
    "email": "daniellyncon@gmail.com",
    "name": "Daniel Lyncon",
    "isActive": true,
    "emailVerified": true,
    "post": "Product Manager",
    "type": "admin",
    "ACL": {
      "*": {"read": true, "write": false},
      "pL74mEhak4": {"read": true, "write": true}
    }
  });
  MonthLaborTime mlt = MonthLaborTime(
    user: user,
    year: 2022,
    month: 3,
    monthReference: "03/2022",
    laborTimeList: <LaborTime>[],
  );
  mlt.laborTimeList.addAll(mlt.createLaborTime());
  final mltList = <MonthLaborTime>[
    mlt,
  ];
  mlt.laborTimeList[0] = laborTimes[0];
  return mltList;
}
