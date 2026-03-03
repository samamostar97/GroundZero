class ImageUtils {
  ImageUtils._();

  static const String _baseHost = 'http://localhost:5147';

  static String? fullImageUrl(String? relativeUrl) {
    if (relativeUrl == null || relativeUrl.isEmpty) return null;
    if (relativeUrl.startsWith('http')) return relativeUrl;
    return '$_baseHost$relativeUrl';
  }
}
