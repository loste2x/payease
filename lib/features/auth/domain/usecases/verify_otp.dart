import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpParams {
  final String mobile;
  final String otp;

  const VerifyOtpParams({required this.mobile, required this.otp});
}

class VerifyOtp {
  final AuthRepository repository;

  VerifyOtp(this.repository);

  Future<User> call(VerifyOtpParams params) {
    return repository.verifyOtp(
      mobile: params.mobile,
      otp: params.otp,
    );
  }
}