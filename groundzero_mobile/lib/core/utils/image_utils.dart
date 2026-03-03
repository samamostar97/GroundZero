class ImageUtils {
  ImageUtils._();

  static const String _baseHost = 'http://10.0.2.2:5147';

  /// Converts a relative image URL (e.g. `/uploads/xyz.jpg`) to a full URL.
  /// Returns null if the input is null or empty.
  static String? fullImageUrl(String? relativeUrl) {
    if (relativeUrl == null || relativeUrl.isEmpty) return null;
    if (relativeUrl.startsWith('http')) return relativeUrl;
    return '$_baseHost$relativeUrl';
  }
}
