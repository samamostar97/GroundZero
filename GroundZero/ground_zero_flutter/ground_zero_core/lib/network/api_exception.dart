import 'package:dio/dio.dart';

extension DioExceptionX on DioException {
  String get readableMessage => switch (type) {
    DioExceptionType.connectionTimeout || DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout => 'Connection timed out.',
    DioExceptionType.connectionError => 'No internet connection.',
    DioExceptionType.badResponse => _extractMessage(),
    _ => 'Something went wrong.',
  };

  String _extractMessage() {
    final data = response?.data;
    if (data is Map && data.containsKey('message')) return data['message'];
    return 'Server error (${response?.statusCode})';
  }
}