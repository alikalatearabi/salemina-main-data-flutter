import 'package:flutter/material.dart';

enum RiskTagLevel { high, medium, low }

class RelatedProduct {
  final String name;
  final String imageUrl;
  final String calories;
  final String sugar;
  final String salt;
  final String fat;

  RelatedProduct({
    required this.name,
    required this.imageUrl,
    required this.calories,
    required this.sugar,
    required this.salt,
    required this.fat,
  });
}

class HealthWarning {
  final int id;
  final String title;
  final String fullDescription;
  final RiskTagLevel riskTagLevel;
  final List<RelatedProduct> relatedProducts;

  HealthWarning({
    required this.id,
    required this.title,
    required this.fullDescription,
    required this.riskTagLevel,
    required this.relatedProducts,
  });
}