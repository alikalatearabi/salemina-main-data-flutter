import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:main_app/models/illness_model.dart';

// Type definition for Disease constructor function
typedef DiseaseConstructor<T> = T Function(String name, List<String> options);

class ApiService {
  final String baseUrl = 'http://localhost:3000/api';

  Future<IllnessResponse> fetchIllnessesWithLevels() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/auth/illnesses-with-levels'),
      );

      if (response.statusCode == 200) {
        return IllnessResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load illnesses: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching illnesses: $e');
    }
  }
  
  // This method maps API diseases to the Disease model used in the UI
  List<T> mapApiIllnessesToDiseases<T>(
    IllnessResponse response, 
    DiseaseConstructor<T> createDisease
  ) {
    // Create a map of disease options based on the disease name
    // This is needed because each disease might have different options
    final diseaseOptionsMap = {
      'Thyroid': ['کم کاری', 'پر کاری', 'نرمال', 'نامشخص'],
      'BloodPressure': ['پایین', 'نرمال', 'بالا', 'نامشخص'],
      'Diabetes': ['سالم', 'پیش دیابت', 'دیابت'],
      'CardiovascularDisease': ['دارم', 'ندارم'],
      'FattyLiver': ['دارم', 'ندارم'],
      'PCOS': ['دارم', 'ندارم'],
      'AbdominalObesity': ['دارم', 'ندارم'],
      'Triglycerides': ['نرمال', 'بالا', 'نامشخص'],
      'Cholesterol': ['نرمال', 'بالا', 'نامشخص'],
      'UricAcid': ['نرمال', 'بالا', 'نامشخص'],
      'Creatinine': ['نرمال', 'بالا', 'نامشخص'],
      'AppetiteStatus': ['کم', 'معمولی', 'زیاد'],
      'AcidReflux': ['دارم', 'ندارم'],
      'Heartburn': ['دارم', 'ندارم'],
      'Anemia': ['دارم', 'ندارم'],
    };
    
    return response.illnesses.map((illness) {
      // Get options for this disease or default to yes/no options
      final options = diseaseOptionsMap[illness.name] ?? ['دارم', 'ندارم'];
      return createDisease(illness.persianName, options);
    }).toList();
  }
}
// This Disease class is moved to disease_page.dart 