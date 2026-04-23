import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../services/auth_http_client.dart';
import '../../../services/auth_storage.dart';
import '../models/user_data_model.dart';

class HomeService {
  static String get baseUrl => '${dotenv.env['BASE_URL']}/api';

  int _toInt(dynamic value, {int fallback = 0}) {
    if (value == null) return fallback;
    if (value is int) return value;
    if (value is double) return value.round();
    return int.tryParse(value.toString()) ?? fallback;
  }

  int? _extractUserIdFromJwt(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;
      var payload = parts[1];
      payload = payload.replaceAll('-', '+').replaceAll('_', '/');
      while (payload.length % 4 != 0) {
        payload += '=';
      }
      final decoded = utf8.decode(base64Decode(payload));
      final map = jsonDecode(decoded) as Map<String, dynamic>;
      return _toInt(map['sub'], fallback: -1) == -1
          ? null
          : _toInt(map['sub'], fallback: -1);
    } catch (_) {
      return null;
    }
  }

  Future<UserData> getHomePageData() async {
    int? userId = await AuthStorage.getUserId();
    if (userId == null) {
      final token = await AuthStorage.getAccessToken();
      if (token != null) {
        userId = _extractUserIdFromJwt(token);
        if (userId != null) {
          await AuthStorage.saveUserId(userId);
        }
      }
    }
    if (userId == null) {
      throw Exception('No userId found. Please sign in again.');
    }

    final response = await authGet(
      Uri.parse('$baseUrl/home/$userId'),
    );

    if (response.statusCode == 401) {
      await AuthStorage.clearTokens();
      throw Exception('401 Unauthorized - Session expired. Please sign in again.');
    }

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to fetch home data (${response.statusCode}): ${response.body}');
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final calories = (body['calories'] as Map<String, dynamic>? ?? {});
    final nutrients = (body['nutrients'] as Map<String, dynamic>? ?? {});
    final water = (body['water'] as Map<String, dynamic>? ?? {});
    final fat = (nutrients['fat'] as Map<String, dynamic>? ?? {});
    final fattyAcid =
        (nutrients['fattyAcid'] as Map<String, dynamic>? ?? {});
    final sugar = (nutrients['sugar'] as Map<String, dynamic>? ?? {});
    final salt = (nutrients['salt'] as Map<String, dynamic>? ?? {});

    return UserData(
      waterConsumed: _toInt(water['consumed']).toDouble(),
      waterGoal: _toInt(water['goal'], fallback: 8).toDouble(),
      healthStatus: (body['healthStatus'] as String?) ?? 'normal',
      subscriptionType: (body['subscriptionType'] as String?) ?? 'free',
      calories: CalorieData(
        consumed: _toInt(calories['consumed']),
        total: _toInt(calories['total'], fallback: 2000),
      ),
      nutrients: NutrientData(
        fat: Nutrient(
          consumed: _toInt(fat['consumed']),
          total: _toInt(fat['total'], fallback: 70),
        ),
        fattyAcid: Nutrient(
          consumed: _toInt(fattyAcid['consumed']),
          total: _toInt(fattyAcid['total'], fallback: 2),
        ),
        sugar: Nutrient(
          consumed: _toInt(sugar['consumed']),
          total: _toInt(sugar['total'], fallback: 30),
        ),
        salt: Nutrient(
          consumed: _toInt(salt['consumed']),
          total: _toInt(salt['total'], fallback: 5),
        ),
      ),
    );
  }

  Future<void> updateWaterConsumed(int consumedGlasses) async {
    int? userId = await AuthStorage.getUserId();
    if (userId == null) {
      final token = await AuthStorage.getAccessToken();
      if (token != null) {
        userId = _extractUserIdFromJwt(token);
        if (userId != null) {
          await AuthStorage.saveUserId(userId);
        }
      }
    }
    if (userId == null) {
      throw Exception('No userId found. Please sign in again.');
    }

    final response = await authPost(
      Uri.parse('$baseUrl/home/$userId/water'),
      body: jsonEncode({
        'consumedGlasses': consumedGlasses,
      }),
    );

    if (response.statusCode == 401) {
      await AuthStorage.clearTokens();
      throw Exception('401 Unauthorized - Session expired. Please sign in again.');
    }
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(
          'Failed to update water (${response.statusCode}): ${response.body}');
    }
  }
}
