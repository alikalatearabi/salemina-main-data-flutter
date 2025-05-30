// Environment configuration for the application
// Contains base URLs and other environment-specific settings

class EnvConfig {
  // Base URL for the API
  static const String apiBaseUrl = 'http://185.236.36.158:3000/api';
  // Store current authenticated user ID
  static int? currentUserId;
  
  // Get full API URL by combining base URL with endpoint
  static String getApiUrl(String endpoint) {
    // Remove leading slash if present in endpoint
    final cleanEndpoint = endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;
    return '$apiBaseUrl/$cleanEndpoint';
  }
} 