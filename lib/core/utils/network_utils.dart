import 'dart:io';

/// Utility class for network-related operations.
class NetworkUtils {
  /// Checks if the device has an active internet connection.
  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Formats an API response error message.
  static String formatError(dynamic error) {
    if (error is SocketException) {
      return 'No Internet connection';
    }
    return 'An unexpected error occurred';
  }
}
