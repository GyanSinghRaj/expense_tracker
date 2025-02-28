/// Abstract base class representing a failure.
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
  @override
  List<Object> get props => [message];
}

/// Failure due to server-related errors.
class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

/// Failure due to caching issues.
class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

/// Failure due to validation errors with custom messages.
class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}
