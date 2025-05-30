import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AllergyCategory {
  final int id;
  final String name;
  final List<AllergyItem> items;

  AllergyCategory(this.id, this.name, this.items);

  factory AllergyCategory.fromJson(Map<String, dynamic> json) {
    final List<dynamic> itemsJson = json['items'] ?? [];
    final List<AllergyItem> items = itemsJson.map((item) => 
      AllergyItem(item['id'] as int, item['persianName'] as String)
    ).toList();
    
    return AllergyCategory(
      json['id'] as int, 
      json['persianName'] as String, 
      items
    );
  }
}

class AllergyItem {
  final int id;
  final String name;
  
  AllergyItem(this.id, this.name);
}

class AllergiesService {
  static String get baseUrl => '${dotenv.env['BASE_URL']}/api';

  static Future<List<AllergyCategory>> getAllergies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/auth/allergies'),
    );
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => AllergyCategory.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch allergies: ${response.body}');
    }
  }

  static Future<void> submitAllergies({
    required int userId,
    required List<int> allergyIds,
  }) async {
    final allergiesList = allergyIds.map((id) => {"id": id}).toList();
    
    final response = await http.post(
      Uri.parse('$baseUrl/auth/signup/allergies'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'allergies': allergiesList,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to submit allergies: ${response.body}');
    }
  }
} 