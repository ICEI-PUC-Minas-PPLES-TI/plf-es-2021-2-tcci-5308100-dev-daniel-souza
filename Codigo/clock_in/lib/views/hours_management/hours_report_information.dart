import 'package:flutter/material.dart';

@immutable
class HoursReportInformation extends StatelessWidget {
  const HoursReportInformation(
      {Key? key, required this.value, required this.label})
      : super(key: key);

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.grey[600],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            padding: const EdgeInsets.all(10),
          ),
        ],
      ),
    );
  }
}
