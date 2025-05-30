import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:main_app/utility/env_config.dart';

class NutritionService {
  /// Fetches user's nutrition data for home page display
  static Future<Map<String, dynamic>> fetchHomeNutrition() async {
    // Use stored userId or throw exception if not available
    final userId = EnvConfig.currentUserId;
    if (userId == null) {
      throw Exception('User ID not available. Please login again.');
    }

    try {
      final response = await http.get(
        Uri.parse('${EnvConfig.apiBaseUrl}/nutrition/home/$userId'),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load nutrition data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load nutrition data: $e');
    }
  }
} 