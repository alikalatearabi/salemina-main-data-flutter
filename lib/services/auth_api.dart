import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  static String get baseUrl => '${dotenv.env['BASE_URL']}/api';

  static Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String code,
    required int userId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/otp/verify'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'phone': '+98$phone',
        'code': code,
        'userId': userId,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception(
        'Failed to verify OTP (${response.statusCode}): ${response.body}',
      );
    }
  }
}

