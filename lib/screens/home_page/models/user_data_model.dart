// TODO: Connect this model to the actual user data structure from the backend.
class UserData {
  final double waterConsumed;
  final double waterGoal;
  final String healthStatus;
  final String subscriptionType;
  final CalorieData calories;
  final NutrientData nutrients;

  UserData({
    required this.waterConsumed,
    required this.waterGoal,
    required this.healthStatus,
    required this.subscriptionType,
    required this.calories,
    required this.nutrients,
  });
}

class CalorieData {
  final int consumed;
  final int total;

  CalorieData({required this.consumed, required this.total});
}

class NutrientData {
  final Nutrient fat;
  final Nutrient fattyAcid;
  final Nutrient sugar;
  final Nutrient salt;

  NutrientData({
    required this.fat,
    required this.fattyAcid,
    required this.sugar,
    required this.salt,
  });
}

class Nutrient {
  final int consumed;
  final int total;

  Nutrient({required this.consumed, required this.total});
}