import 'package:intl/intl.dart';

extension StringExtension on String {
  bool isEmailValid() {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);
  }
}

extension DateTimeExtension on DateTime {
  String getMonthReference() {
    final DateFormat formatter = DateFormat('MM/yyyy');
    final String formatted = formatter.format(this);
    return formatted;
  }
}

extension DoubleExtension on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}
