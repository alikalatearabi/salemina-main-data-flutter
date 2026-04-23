import 'dart:convert';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'auth_http_client.dart';

class UserService {
  static String get baseUrl => '${dotenv.env['BASE_URL']}/api';
  
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
    final response = await authPost(
      Uri.parse('$baseUrl/auth/signup/basic-info'),
      body: json.encode({
        'userId': userId,
        'name': name,
        'gender': gender.toUpperCase() == 'MAN' ? 'MALE' : 'FEMALE',
        'birthDate': '${birthDate.year}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}',
      }),
    );
    
    if (response.statusCode == 200 || response.statusCode == 201) {
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
    
    final response = await authPost(
      Uri.parse('$baseUrl/auth/signup/basic-info'),
      body: json.encode({
        'userId': userId,
        'name': name,
        'gender': gender.toUpperCase() == 'MAN' ? 'MALE' : 'FEMALE',
        'birthDate': gregorianDate,
      }),
    );
    
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to submit basic info: ${response.body}');
    }
  }
} 