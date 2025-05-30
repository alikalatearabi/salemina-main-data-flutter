import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ActivityLevel {
  final int id;
  final String name;
  final String nameFa;
  final String description;
  final String descriptionFa;

  ActivityLevel({
    required this.id,
    required this.name,
    required this.nameFa,
    required this.description,
    required this.descriptionFa,
  });

  factory ActivityLevel.fromJson(Map<String, dynamic> json) {
    return ActivityLevel(
      id: json['id'],
      name: json['name'],
      nameFa: json['name_fa'],
      description: json['description'],
      descriptionFa: json['description_fa'],
    );
  }
}

class ActivityLevelService {
  static String get baseUrl => '${dotenv.env['BASE_URL']}/api';

  static Future<List<ActivityLevel>> getActivityLevels() async {
    final response = await http.get(
      Uri.parse('$baseUrl/auth/activity-levels'),
    );
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => ActivityLevel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch activity levels: ${response.body}');
    }
  }
} 