import '../models/user_data_model.dart';

class HomeService {
  // TODO: Implement the actual API call to fetch user data from the backend.
  // This function should handle HTTP requests, parsing JSON, and error handling.
  Future<UserData> getHomePageData() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Return mock data
    return UserData(
      waterConsumed: 3, // Liters or glasses
      waterGoal: 8,
      healthStatus: 'highRisk', // Corresponds to HealthLevel enum
      subscriptionType: 'free', // 'free' or 'premium'
      calories: CalorieData(consumed: 750, total: 2200),
      nutrients: NutrientData(
        fat: Nutrient(consumed: 30, total: 70),
        fattyAcid: Nutrient(consumed: 10, total: 20),
        sugar: Nutrient(consumed: 40, total: 90),
        salt: Nutrient(consumed: 2, total: 6),
      ),
    );
  }
}