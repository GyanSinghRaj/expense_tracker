/// Utility class for string-related operations.
class StringUtils {
  /// Capitalizes the first letter of a string.
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  /// Checks if a string is null, empty, or contains only whitespace.
  static bool isNullOrEmpty(String? text) {
    return text == null || text.trim().isEmpty;
  }

  /// Converts a list of strings to a comma-separated string.
  static String joinWithComma(List<String> items) {
    return items.join(', ');
  }
}
