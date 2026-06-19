import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Loading state (OTP sending / verifying)
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// OTP sent successfully
class OtpSentSuccess extends AuthState {
  final String mobile;

  const OtpSentSuccess(this.mobile);

  @override
  List<Object?> get props => [mobile];
}

/// User authenticated successfully
class Authenticated extends AuthState {
  final User user;

  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// Auth failed
class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}