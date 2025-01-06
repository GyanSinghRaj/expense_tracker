import 'dart:math' as Math;

/// Utility class for number-related operations.
class NumberUtils {
  /// Formats a number with commas (e.g., 1,000,000).
  static String formatWithCommas(int number) {
    return number
        .toString()
        .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',');
  }

  /// Rounds a double to the specified number of decimal places.
  static double roundTo(double value, int decimalPlaces) {
    final factor = Math.pow(10, decimalPlaces);
    return (value * factor).round() / factor;
  }
}
