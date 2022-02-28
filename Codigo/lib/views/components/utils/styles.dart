import 'package:flutter/material.dart';

TextStyle getTextLabelStyle() {
  return const TextStyle(
    fontWeight: FontWeight.w800,
    color: Colors.grey,
    fontSize: 18,
  );
}

EdgeInsetsGeometry getContentPadding() {
  return const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0);
}

TextStyle getFormTextStyle() {
  return const TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontSize: 18,
    letterSpacing: 0.5,
    fontStyle: FontStyle.normal,
  );
}
