import 'package:flutter/material.dart';
enum HealthLevel {
  perfect,
  normal,
  atRisk,
  mediumRisk,
  highRisk,
}



class HealthStatusInfo {
  final String title;
  final String iconAsset;
  final Color color;
  final int levelValue;

  HealthStatusInfo({
    required this.title,
    required this.iconAsset,
    required this.color,
    required this.levelValue,
  });
}