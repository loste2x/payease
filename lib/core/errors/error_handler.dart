import 'package:dio/dio.dart';

import 'exceptions.dart';
import 'failures.dart';

/// Centralized error handling
class ErrorHandler {
  static Failure handle(dynamic exception) {
    if (exception is NetworkException) {
      return NetworkFailure(
        message: exception.message,
        statusCode: exception.statusCode,
      );
    }

    if (exception is ParseException) {
      return ParseFailure(message: exception.message);
    }

    if (exception is ValidationException) {
      return ValidationFailure(
        message: exception.message,
        errors: exception.errors,
      );
    }

    if (exception is AuthException) {
      return AuthFailure(message: exception.message);
    }

    if (exception is UnAuthenticatedException) {
      return UnAuthenticatedFailure(message: exception.message);
    }

    if (exception is UnAuthorizedException) {
      return UnAuthorizedFailure(message: exception.message);
    }

    if (exception is NotFoundException) {
      return NotFoundFailure(message: exception.message);
    }

    if (exception is RateLimitException) {
      return RateLimitFailure(
        message: exception.message,
        retryAfter: exception.retryAfter,
      );
    }

    if (exception is TimeoutException) {
      return TimeoutFailure(message: exception.message);
    }

    if (exception is DioException) {
      return _handleDioException(exception);
    }

    if (exception is AppException) {
      return AppFailure(message: exception.message);
    }

    return AppFailure(message: exception.toString());
  }

  static Failure _handleDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return TimeoutFailure(
          message: 'Connection timeout. Please check your internet connection.',
        );
      case DioExceptionType.receiveTimeout:
        return TimeoutFailure(
          message: 'Server response timeout. Please try again.',
        );
      case DioExceptionType.sendTimeout:
        return TimeoutFailure(
          message: 'Request timeout. Please try again.',
        );
      case DioExceptionType.badResponse:
        return _handleBadResponse(exception.response);
      case DioExceptionType.badCertificate:
        return NetworkFailure(
          message: 'SSL Certificate Error',
          statusCode: exception.response?.statusCode,
        );
      case DioExceptionType.connectionError:
        return NetworkFailure(
          message: 'Connection error. Please check your internet connection.',
          statusCode: exception.response?.statusCode,
        );
      case DioExceptionType.unknown:
        return NetworkFailure(
          message: 'An unknown network error occurred',
          statusCode: exception.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return AppFailure(message: 'Request cancelled');
    }
  }

  static Failure _handleBadResponse(Response? response) {
    if (response == null) {
      return NetworkFailure(message: 'Unknown error occurred');
    }

    final int statusCode = response.statusCode ?? 0;
    final dynamic data = response.data;

    String errorMessage = 'An error occurred';
    if (data is Map<String, dynamic>) {
      errorMessage = data['message'] ?? data['error'] ?? errorMessage;
    } else if (data is String) {
      errorMessage = data;
    }

    switch (statusCode) {
      case 400:
        return ValidationFailure(message: errorMessage);
      case 401:
        return UnAuthenticatedFailure(message: errorMessage);
      case 403:
        return UnAuthorizedFailure(message: errorMessage);
      case 404:
        return NotFoundFailure(message: errorMessage);
      case 429:
        return RateLimitFailure(message: errorMessage);
      case 500:
      case 502:
      case 503:
      case 504:
        return ServerFailure(message: 'Server error. Please try again later.');
      default:
        return NetworkFailure(
          message: errorMessage,
          statusCode: statusCode,
        );
    }
  }
}
