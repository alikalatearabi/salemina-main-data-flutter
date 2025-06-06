import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class IllnessLevel {
  final int id;
  final String name;
  final String persianName;
  final int illnessId;

  IllnessLevel({
    required this.id,
    required this.name,
    required this.persianName,
    required this.illnessId,
  });

  factory IllnessLevel.fromJson(Map<String, dynamic> json) {
    return IllnessLevel(
      id: json['id'] as int,
      name: json['name'] as String,
      persianName: json['persianName'] as String,
      illnessId: json['illnessId'] as int,
    );
  }
}

class Disease {
  final int id;
  final String name;
  final List<IllnessLevel> levels;

  Disease(this.id, this.name, this.levels);

  factory Disease.fromJson(Map<String, dynamic> json) {
    final List<dynamic> levelsJson = json['levels'] ?? [];
    return Disease(
      json['id'] as int,
      json['persianName'] as String,
      levelsJson.map((level) => IllnessLevel.fromJson(level)).toList(),
    );
  }
}

class DiseaseService {
  static String get baseUrl => '${dotenv.env['BASE_URL']}/api';

  static Future<List<Disease>> getDiseases() async {
    final response = await http.get(
      Uri.parse('$baseUrl/auth/illnesses'),
    );
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Disease.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch diseases: ${response.body}');
    }
  }

  static Future<void> submitHealthInfo({
    required int userId,
    required String activityLevel,
    required List<Map<String, dynamic>> illnesses,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/signup/health-info'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'activityLevel': activityLevel,
        'illnesses': illnesses,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to submit health info: ${response.body}');
    }
  }

  static String getActivityLevelString(int activityLevelId) {
    switch (activityLevelId) {
      case 1:
        return "LOW";
      case 2:
        return "MODERATE";
      case 3:
        return "HIGH";
      case 4:
        return "VERY_HIGH";
      default:
        return "MODERATE";
    }
  }

  static String getStandardLevel(String level) {
    if (level.contains("بالا") || level == "دارم") {
      return "HIGH";
    } else if (level.contains("پایین") || level.contains("کم")) {
      return "LOW";
    } else if (level.contains("نرمال") || level == "ندارم") {
      return "NORMAL";
    }
    return "MEDIUM";
  }
} 