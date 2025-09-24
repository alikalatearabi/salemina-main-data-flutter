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

// Helper function to map a HealthLevel to its corresponding display info
HealthStatusInfo getHealthStatusInfo(HealthLevel level) {
  switch (level) {
    case HealthLevel.perfect:
      return HealthStatusInfo(
        title: 'سلامت کامل',
        iconAsset: 'assets/icons/green_face.svg',
        color: const Color(0xFF25A749),
        levelValue: 5,
      );
    case HealthLevel.normal:
      return HealthStatusInfo(
        title: 'نرمال',
        iconAsset: 'assets/icons/light_green_face.svg',
        color: const Color(0xFF4BD772),
        levelValue: 4,
      );
    case HealthLevel.atRisk:
      return HealthStatusInfo(
        title: 'در معرض ابتلا',
        iconAsset: 'assets/icons/orange_face.svg',
        color: const Color(0xFFF5AE32),
        levelValue: 3,
      );
    case HealthLevel.mediumRisk:
      return HealthStatusInfo(
        title: 'ریسک متوسط',
        iconAsset: 'assets/icons/pink_face.svg',
        color: const Color(0xFFF2506E),
        levelValue: 2,
      );
    case HealthLevel.highRisk:
      return HealthStatusInfo(
        title: 'ریسک بالا',
        iconAsset: 'assets/icons/red_face.svg',
        color: const Color(0xFFD44661),
        levelValue: 1,
      );
  }
}