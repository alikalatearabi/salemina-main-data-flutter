import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'auth_http_client.dart';

class WaterIntakeService {
  static String get baseUrl => '${dotenv.env['BASE_URL']}/api';

  static Future<void> submitWaterIntake({
    required int userId,
    required int waterIntake,
  }) async {
    final response = await authPost(
      Uri.parse('$baseUrl/auth/signup/water-intake'),
      body: jsonEncode({
        'userId': userId,
        'waterIntake': waterIntake,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to submit water intake: ${response.body}');
    }
  }
} 