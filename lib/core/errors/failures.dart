import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  final int? statusCode;

  const NetworkFailure({
    required super.message,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message, statusCode];
}

class ParseFailure extends Failure {
  const ParseFailure({required super.message});
}

class ValidationFailure extends Failure {
  final Map<String, dynamic>? errors;

  const ValidationFailure({
    required super.message,
    this.errors,
  });

  @override
  List<Object?> get props => [message, errors];
}

class AuthFailure extends Failure {
  const AuthFailure({required super.message});
}

class UnAuthenticatedFailure extends Failure {
  const UnAuthenticatedFailure({super.message = 'User is not authenticated'});
}

class UnAuthorizedFailure extends Failure {
  const UnAuthorizedFailure({super.message = 'User is not authorized'});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({required super.message});
}

class RateLimitFailure extends Failure {
  final Duration? retryAfter;

  const RateLimitFailure({
    required super.message,
    this.retryAfter,
  });

  @override
  List<Object?> get props => [message, retryAfter];
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({required super.message});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

class AppFailure extends Failure {
  const AppFailure({required super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}
