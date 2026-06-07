import '../entities/user.dart';

abstract class AuthRepository {
  Future<void> sendOtp(String mobile);
  Future<User> verifyOtp({required String mobile, required String otp});
}
