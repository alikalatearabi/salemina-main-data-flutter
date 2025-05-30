import 'package:main_app/services/nutrition_service.dart';

// Return health icon for current day
String getHealthIcon() {
  return 'smiley-happy';
}

// Return health text for current day
String getHealthText() {
  return 'سلامتی عالی';
}

// Return health level (1-6) for current day
int getHealthLevel() {
  return 4;
}

// Function to calculate overall health level based on nutrition percentages
Future<Map<String, dynamic>> calculateHealthScore() async {
  try {
    // Fetch nutrition data
    final data = await NutritionService.fetchHomeNutrition();
    
    // Get percentage values
    final fatPercentage = data['nutritionPercentage']['fat'] ?? 0.0;
    final sugarPercentage = data['nutritionPercentage']['sugar'] ?? 0.0;
    final saltPercentage = data['nutritionPercentage']['salt'] ?? 0.0;
    final transfattyPercentage = data['nutritionPercentage']['transfattyAcids'] ?? 0.0;
    
    // Calculate health score (1-6)
    // Lower is better if over 100%
    int score = 6;
    
    // Reduce score for each nutrient that exceeds 100%
    if (fatPercentage > 100) score--;
    if (sugarPercentage > 100) score--;
    if (saltPercentage > 100) score--;
    if (transfattyPercentage > 100) score--;
    
    // Ensure score is between 1-6
    score = score.clamp(1, 6);
    
    // Determine health text
    String healthText = 'سلامتی عالی';
    if (score <= 2) {
      healthText = 'سلامتی ضعیف';
    } else if (score <= 4) {
      healthText = 'سلامتی متوسط';
    }
    
    // Determine health icon
    String healthIcon = 'smiley-happy';
    if (score <= 2) {
      healthIcon = 'smiley-sad';
    } else if (score <= 4) {
      healthIcon = 'smiley-neutral';
    }
    
    return {
      'score': score,
      'healthText': healthText,
      'healthIcon': healthIcon,
    };
  } catch (e) {
    // Default values on error
    return {
      'score': 4,
      'healthText': 'سلامتی متوسط',
      'healthIcon': 'smiley-neutral',
    };
  }
}