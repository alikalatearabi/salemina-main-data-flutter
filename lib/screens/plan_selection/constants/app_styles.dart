import 'package:flutter/material.dart';

const BorderRadius modalTopRadius = BorderRadius.vertical(top: Radius.elliptical(600, 50));

BoxDecoration modalBoxDecoration() {
  return const BoxDecoration(
    color: Colors.white,
    borderRadius: modalTopRadius,
  );
}

TextStyle titleTextStyle({double fontSize = 18, Color color = Colors.black87}) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.bold,
    color: color,
  );
}

TextStyle subtitleTextStyle({double fontSize = 14, Color color = Colors.black54}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
  );
}