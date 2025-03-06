import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class FoodItemData {
  final String label;
  final num value;
  final String unit;
  final String status;
  final Color? statusTextColor;
  final Widget icon;

  FoodItemData({
    required this.label,
    required this.value,
    this.unit = '',
    required this.status,
    this.statusTextColor,
    required this.icon,
  });
}