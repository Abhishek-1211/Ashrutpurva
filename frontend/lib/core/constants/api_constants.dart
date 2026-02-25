class ApiConstants {
  static const String baseUrl = 'http://127.0.0.1:8000/api';
  static const String baseUrlAndroid = 'http://10.0.2.2:8000/api';// Using localhost for Web compatibility
  // For Web/Production, this would be updated or use environment variables
  
  // Auth
  static const String register = '/users/register/';
  static const String login = '/users/login/';
  static const String profile = '/users/profile/';
  static const String refreshToken = '/users/token/refresh/';
  
  // Content
  static const String poems = '/content/poems/';
  static const String events = '/content/events/';
  static const String mediaCoverage = '/content/media-coverage/';
  static const String blogs = '/content/blogs/';
  static const String videos = '/content/videos/';
  static const String books = '/content/books/';
  static const String categories = '/content/categories/';
}
