import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Send OTP to mobile
class SendOtpRequested extends AuthEvent {
  final String mobile;

  const SendOtpRequested(this.mobile);

  @override
  List<Object?> get props => [mobile];
}

/// Verify OTP
class VerifyOtpRequested extends AuthEvent {
  final String mobile;
  final String otp;

  const VerifyOtpRequested({required this.mobile, required this.otp});

  @override
  List<Object?> get props => [mobile, otp];
}

/// Reset auth state (e.g., back from OTP page)
class AuthReset extends AuthEvent {
  const AuthReset();
}