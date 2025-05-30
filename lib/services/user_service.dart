import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shamsi_date/shamsi_date.dart';
import 'package:main_app/utility/env_config.dart';

class UserService {
  static const String baseUrl = EnvConfig.apiBaseUrl;
  
  // Convert Jalali date to ISO format (YYYY-MM-DD)
  static String jalaliToGregorian(int year, int month, int day) {
    final jalali = Jalali(year, month, day);
    final gregorian = jalali.toGregorian();
    return '${gregorian.year}-${gregorian.month.toString().padLeft(2, '0')}-${gregorian.day.toString().padLeft(2, '0')}';
  }
  
  // Submit basic user information
  static Future<Map<String, dynamic>> submitBasicInfo({
    required int userId,
    required String name,
    required String gender,
    required DateTime birthDate,
  }) async {
    final response = await http.post(
      Uri.parse('${EnvConfig.apiBaseUrl}/auth/signup/basic-info'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'userId': userId,
        'name': name,
        'gender': gender.toUpperCase() == 'MAN' ? 'MALE' : 'FEMALE',
        'birthDate': '${birthDate.year}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}',
      }),
    );
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to submit basic info: ${response.body}');
    }
  }
  
  // Submit basic user information with Jalali date
  static Future<Map<String, dynamic>> submitBasicInfoWithJalali({
    required int userId,
    required String name,
    required String gender,
    required int birthYear,
    required int birthMonth,
    required int birthDay,
  }) async {
    final gregorianDate = jalaliToGregorian(birthYear, birthMonth, birthDay);
    
    final response = await http.post(
      Uri.parse('${EnvConfig.apiBaseUrl}/auth/signup/basic-info'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'userId': userId,
        'name': name,
        'gender': gender.toUpperCase() == 'MAN' ? 'MALE' : 'FEMALE',
        'birthDate': gregorianDate,
      }),
    );
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to submit basic info: ${response.body}');
    }
  }
} 