import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class SendOtpEvent extends AuthEvent {
  final String mobile;
  const SendOtpEvent(this.mobile);
  @override
  List<Object?> get props => [mobile];
}

class VerifyOtpEvent extends AuthEvent {
  final String mobile;
  final String otp;
  const VerifyOtpEvent({required this.mobile, required this.otp});
  @override
  List<Object?> get props => [mobile, otp];
}
