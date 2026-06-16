/// Custom exception for network errors
class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic originalException;

  NetworkException({
    required this.message,
    this.statusCode,
    this.originalException,
  });

  @override
  String toString() => 'NetworkException: $message (StatusCode: $statusCode)';
}

/// Custom exception for parsing/serialization errors
class ParseException implements Exception {
  final String message;
  final dynamic originalException;

  ParseException({
    required this.message,
    this.originalException,
  });

  @override
  String toString() => 'ParseException: $message';
}

/// Custom exception for validation errors
class ValidationException implements Exception {
  final String message;
  final Map<String, dynamic>? errors;

  ValidationException({
    required this.message,
    this.errors,
  });

  @override
  String toString() => 'ValidationException: $message';
}

/// Custom exception for authentication errors
class AuthException implements Exception {
  final String message;
  final int? statusCode;

  AuthException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => 'AuthException: $message';
}

/// Custom exception when user is not authenticated
class UnAuthenticatedException implements Exception {
  final String message;

  UnAuthenticatedException({
    this.message = 'User is not authenticated',
  });

  @override
  String toString() => 'UnAuthenticatedException: $message';
}

/// Custom exception when operation is not authorized
class UnAuthorizedException implements Exception {
  final String message;

  UnAuthorizedException({
    this.message = 'User is not authorized to perform this action',
  });

  @override
  String toString() => 'UnAuthorizedException: $message';
}

/// Custom exception when resource not found
class NotFoundException implements Exception {
  final String message;

  NotFoundException({
    required this.message,
  });

  @override
  String toString() => 'NotFoundException: $message';
}

/// Custom exception for rate limiting
class RateLimitException implements Exception {
  final String message;
  final Duration? retryAfter;

  RateLimitException({
    required this.message,
    this.retryAfter,
  });

  @override
  String toString() => 'RateLimitException: $message';
}

/// Custom exception for timeout errors
class TimeoutException implements Exception {
  final String message;
  final Duration? duration;

  TimeoutException({
    required this.message,
    this.duration,
  });

  @override
  String toString() => 'TimeoutException: $message';
}

/// Generic application exception
class AppException implements Exception {
  final String message;
  final dynamic originalException;

  AppException({
    required this.message,
    this.originalException,
  });

  @override
  String toString() => 'AppException: $message';
}
