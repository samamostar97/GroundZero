import 'dart:io' show Platform;

class ApiConstants {
  ApiConstants._();

  /// Desktop/iOS simulator: localhost works directly.
  /// Android emulator: 10.0.2.2 maps to host loopback.
  /// Physical device: use your machine's LAN IP or a deployed URL.
  static String get baseUrl {
    const configuredUrl = String.fromEnvironment('API_BASE_URL');
    if (configuredUrl.isNotEmpty) return configuredUrl;

    // Default: auto-detect platform
    final host = Platform.isAndroid ? '10.0.2.2' : 'localhost';
    return 'https://$host:7001/api';
  }

  static const String login = '/Auth/login';
  static const String register = '/Auth/register';
  static const String products = '/Products';
  static String productById(String id) => '/Products/$id';
}