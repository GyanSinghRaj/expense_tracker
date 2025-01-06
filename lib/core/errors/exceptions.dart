/// Custom exceptions to represent specific error conditions.
class ServerException implements Exception {}

class CacheException implements Exception {}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
}
