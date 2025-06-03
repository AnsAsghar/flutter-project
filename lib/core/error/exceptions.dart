/// Base exception class for all exceptions in the application
class AppException implements Exception {
  final String message;
  
  const AppException(this.message);
  
  @override
  String toString() => 'AppException: $message';
}

/// Server-related exceptions
class ServerException extends AppException {
  const ServerException([String message = 'Server error occurred']) : super(message);
}

/// Cache-related exceptions
class CacheException extends AppException {
  const CacheException([String message = 'Cache error occurred']) : super(message);
}

/// Network-related exceptions
class NetworkException extends AppException {
  const NetworkException([String message = 'Network error occurred']) : super(message);
}

/// Validation-related exceptions
class ValidationException extends AppException {
  const ValidationException([String message = 'Validation failed']) : super(message);
}

/// Permission-related exceptions
class PermissionException extends AppException {
  const PermissionException([String message = 'Permission denied']) : super(message);
}

/// File-related exceptions
class FileException extends AppException {
  const FileException([String message = 'File operation failed']) : super(message);
}
