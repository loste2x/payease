import '../entities/user.dart';

abstract class AuthRepository {
  /// Send OTP to the given mobile number
  Future<void> sendOtp(String mobile);

  /// Verify OTP and return User on success
  Future<User> verifyOtp({
    required String mobile,
    required String otp,
  });
}