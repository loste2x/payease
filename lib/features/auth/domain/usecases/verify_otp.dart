import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class VerifyOtp {
  final AuthRepository repository;
  VerifyOtp(this.repository);
  Future<User> call({required String mobile, required String otp}) =>
      repository.verifyOtp(mobile: mobile, otp: otp);
}
