import '../models/user_model.dart';

class AuthRemoteDataSource {
  Future<void> sendOtp(String mobile) async {
    await Future.delayed(const Duration(seconds: 1));
    if (mobile.length != 10) throw Exception('Enter valid 10-digit number');
  }

  Future<UserModel> verifyOtp({required String mobile, required String otp}) async {
    await Future.delayed(const Duration(seconds: 1));
    if (otp != '123456') throw Exception('Invalid OTP. Demo OTP: 123456');
    return UserModel(id: 'user_001', name: 'PayEase User', mobile: mobile);
  }
}
