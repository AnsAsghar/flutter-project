import 'package:equatable/equatable.dart';

/// Base failure class for all errors in the application
abstract class Failure extends Equatable {
  final String message;
  
  const Failure(this.message);
  
  @override
  List<Object> get props => [message];
}

/// Server-related failures
class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server error occurred']) : super(message);
}

/// Cache-related failures
class CacheFailure extends Failure {
  const CacheFailure([String message = 'Cache error occurred']) : super(message);
}

/// Network-related failures
class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Network error occurred']) : super(message);
}

/// Validation-related failures
class ValidationFailure extends Failure {
  const ValidationFailure([String message = 'Validation failed']) : super(message);
}

/// Permission-related failures
class PermissionFailure extends Failure {
  const PermissionFailure([String message = 'Permission denied']) : super(message);
}

/// File-related failures
class FileFailure extends Failure {
  const FileFailure([String message = 'File operation failed']) : super(message);
}
