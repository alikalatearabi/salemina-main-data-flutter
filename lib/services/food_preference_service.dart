import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FoodPreference {
  final String title;
  final String description;
  final int id;

  FoodPreference(this.title, this.description, this.id);

  factory FoodPreference.fromJson(Map<String, dynamic> json) {
    String title = (json['name_fa'] as String).isNotEmpty
        ? json['name_fa'] as String
        : json['name'] as String;
    return FoodPreference(title, json['description'] as String, json['id'] as int);
  }
}

class FoodPreferenceService {
  static String get baseUrl => '${dotenv.env['BASE_URL']}/api';

  static Future<List<FoodPreference>> getFoodPreferences() async {
    final response = await http.get(
      Uri.parse('$baseUrl/auth/full-food-preferences'),
    );
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => FoodPreference.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch food preferences: ${response.body}');
    }
  }

  static Future<void> submitDietaryPreferences({
    required int userId,
    required String appetiteMode,
    required List<Map<String, dynamic>> foodPreferences,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/signup/dietary-preferences'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'appetiteMode': appetiteMode,
        'foodPreferences': foodPreferences,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to submit dietary preferences: ${response.body}');
    }
  }
} 