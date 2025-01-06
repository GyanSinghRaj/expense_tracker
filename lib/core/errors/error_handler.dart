import 'exceptions.dart';
import 'failures.dart';

/// A centralized error handler to map exceptions to failures.
class ErrorHandler {
  /// Maps exceptions to user-friendly [Failure] objects.
  static Failure mapExceptionToFailure(Exception exception) {
    if (exception is ServerException) {
      return const ServerFailure('A server error occurred. Please try again.');
    } else if (exception is CacheException) {
      return const CacheFailure(
          'Failed to access cache. Please reload the app.');
    } else if (exception is ValidationException) {
      return ValidationFailure(exception.message);
    } else {
      return const Failure('An unexpected error occurred. Please try again.');
    }
  }
}
