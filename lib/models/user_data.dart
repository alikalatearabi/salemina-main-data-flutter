class UserData {
  // Singleton instance map keyed by userId
  static final Map<int, UserData> _instances = {};

  // Factory constructor to get instance by userId
  static UserData getInstance(int userId) {
    _instances[userId] ??= UserData._internal(userId);
    return _instances[userId]!;
  }

  // Private constructor
  UserData._internal(this.userId);

  // User identification
  final int userId;

  // Basic info
  String? name;
  String? gender;
  int? birthYear;
  int? birthMonth;
  int? birthDay;

  // Physical attributes
  int? height; // in cm
  double? weight; // in kg
  double? idealWeight; // in kg

  // Health info
  int? activityLevelId;
  List<Map<String, dynamic>> selectedIllnesses = [];

  // Dietary preferences
  String? appetiteLevel;
  String? dietType;
  List<String> allergies = [];
  int? waterIntake; // glasses per day

  // Helper method to check if basic info is complete
  bool get hasCompletedBasicInfo =>
      name != null &&
      gender != null &&
      birthYear != null &&
      birthMonth != null &&
      birthDay != null;
      
  // Helper method to check if physical attributes are complete
  bool get hasCompletedPhysicalAttributes =>
      height != null && weight != null && idealWeight != null;
      
  // Helper method to check if health info is complete
  bool get hasCompletedHealthInfo =>
      activityLevelId != null;
      
  // Clear data when needed (e.g., logout)
  void clear() {
    name = null;
    gender = null;
    birthYear = null;
    birthMonth = null;
    birthDay = null;
    height = null;
    weight = null;
    idealWeight = null;
    activityLevelId = null;
    selectedIllnesses.clear();
    appetiteLevel = null;
    dietType = null;
    allergies.clear();
    waterIntake = null;
  }
} 