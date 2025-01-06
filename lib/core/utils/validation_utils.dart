/// Utility class for validation-related operations.
class ValidationUtils {
  /// Validates an email address.
  static bool isValidEmail(String email) {
    const emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    return RegExp(emailRegex).hasMatch(email);
  }

  /// Validates a password (e.g., minimum length of 6).
  static bool isValidPassword(String password) {
    return password.length >= 6;
  }

  /// Validates if a string contains only numeric characters.
  static bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }
}
