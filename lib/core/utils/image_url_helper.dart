import 'package:flutter/foundation.dart';

class ImageUrlHelper {
  static const String _mainBaseUrl =
      'https://yellowgreen-ferret-878816.hostingersite.com';
  static const String _alternateBaseUrl =
      'https://yellowgreen-ferret-878816.hostingersite.com';

  /// Normalizes image URLs to ensure they load correctly
  ///
  /// This method handles different URL formats and ensures they're correctly formatted
  /// with the appropriate base URL.
  static String normalizeImageUrl(String imageUrl) {
    if (imageUrl.isEmpty) {
      return ''; // Return empty for empty inputs
    }

    // If it's a complete URL
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      // Check if the URL points to the models directory with jpg extension (which is failing)
      if (imageUrl.contains('$_mainBaseUrl/models/') &&
          imageUrl.endsWith('.jpg')) {
        // Try with png extension instead
        return imageUrl.replaceAll('.jpg', '.png');
      }

      // If it's from the main base URL that's failing with models directory
      if (imageUrl.contains('$_mainBaseUrl/models/')) {
        // Try the alternate base URL with the models directory path
        final imageName = imageUrl.split('/').last;
        return '$_alternateBaseUrl/models/$imageName';
      }

      return imageUrl;
    }

    // If it's a relative path
    if (imageUrl.startsWith('/')) {
      imageUrl = imageUrl.substring(1); // Remove leading slash
    }

    // Default to the main URL pattern
    return '$_mainBaseUrl/$imageUrl';
  }

  /// For debugging: logs image loading errors
  static void logImageError(String url, Object error) {
    if (kDebugMode) {
      print('Image loading error for $url: $error');
    }
  }
}
