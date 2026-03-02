import 'package:dio/dio.dart';

class ApiException implements Exception {
  final int statusCode;
  final List<String> errors;

  ApiException({
    required this.statusCode,
    required this.errors,
  });

  factory ApiException.fromDioException(DioException e) {
    final response = e.response;
    if (response != null && response.data is Map<String, dynamic>) {
      final data = response.data as Map<String, dynamic>;
      final errors = <String>[];

      if (data.containsKey('errors')) {
        final rawErrors = data['errors'];
        if (rawErrors is List) {
          errors.addAll(rawErrors.map((e) => e.toString()));
        } else if (rawErrors is Map) {
          for (final value in rawErrors.values) {
            if (value is List) {
              errors.addAll(value.map((e) => e.toString()));
            } else {
              errors.add(value.toString());
            }
          }
        }
      }

      return ApiException(
        statusCode: response.statusCode ?? 500,
        errors: errors.isEmpty ? [_defaultMessage(response.statusCode)] : errors,
      );
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return ApiException(
        statusCode: 408,
        errors: ['Konekcija je istekla. Pokušajte ponovo.'],
      );
    }

    if (e.type == DioExceptionType.connectionError) {
      return ApiException(
        statusCode: 0,
        errors: ['Nema internet konekcije. Provjerite vezu.'],
      );
    }

    return ApiException(
      statusCode: 500,
      errors: ['Neočekivana greška. Pokušajte ponovo.'],
    );
  }

  static String _defaultMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Neispravan zahtjev.';
      case 401:
        return 'Niste prijavljeni.';
      case 403:
        return 'Nemate pristup ovom resursu.';
      case 404:
        return 'Resurs nije pronađen.';
      case 409:
        return 'Konflikt — resurs već postoji.';
      case 500:
        return 'Serverska greška. Pokušajte ponovo.';
      default:
        return 'Neočekivana greška.';
    }
  }

  String get firstError => errors.isNotEmpty ? errors.first : 'Nepoznata greška.';

  @override
  String toString() => 'ApiException($statusCode): ${errors.join(', ')}';
}
