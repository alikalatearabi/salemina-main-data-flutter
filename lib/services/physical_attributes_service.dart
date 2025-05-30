import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PhysicalAttributesService {
  static String get baseUrl => '${dotenv.env['BASE_URL']}/api';

  static Future<Map<String, dynamic>> submitPhysicalAttributes({
    required int userId,
    required int height,
    required double weight,
    required double idealWeight,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/signup/physical-attributes'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userId': userId,
        'height': height,
        'weight': weight,
        'idealWeight': idealWeight,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to submit physical attributes: ${response.body}');
    }
  }
} 