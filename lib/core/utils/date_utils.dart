import 'package:intl/intl.dart';

/// Utility class for date-related operations.
class DateUtils {
  /// Formats a DateTime object into a readable string.
  static String formatDate(DateTime date, {String format = 'yyyy-MM-dd'}) {
    return DateFormat(format).format(date);
  }

  /// Calculates the difference in days between two dates.
  static int daysBetween(DateTime start, DateTime end) {
    return end.difference(start).inDays;
  }

  /// Checks if a date is in the past.
  static bool isPastDate(DateTime date) {
    return date.isBefore(DateTime.now());
  }
}
