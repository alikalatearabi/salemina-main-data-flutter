import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ActivityOption {
  final String id;
  final String title;

  ActivityOption(this.id, this.title);

  factory ActivityOption.fromJson(Map<String, dynamic> json) {
    return ActivityOption(json['id'] as String, json['name_fa'] as String);
  }
}

class DietService {
  static String get baseUrl => '${dotenv.env['BASE_URL']}/api';

  static Future<List<ActivityOption>> getAppetiteModes() async {
    final response = await http.get(
      Uri.parse('$baseUrl/auth/appetite-modes'),
    );
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => ActivityOption.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch appetite modes: ${response.body}');
    }
  }
} 