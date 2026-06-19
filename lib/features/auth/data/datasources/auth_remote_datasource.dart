import '../../../../core/constants/app_constants.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> sendOtp(String mobile);
  Future<UserModel> verifyOtp({required String mobile, required String otp});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<void> sendOtp(String mobile) async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1200));

    if (mobile.length != 10) {
      throw Exception('Enter valid 10-digit mobile number');
    }

    // ✅ In real app: call backend API to send OTP
    // For demo: OTP is always 123456
    return;
  }

  @override
  Future<UserModel> verifyOtp({
    required String mobile,
    required String otp,
  }) async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1200));

    if (otp != AppConstants.demoOtp) {
      throw Exception('Invalid OTP. Use demo OTP: ${AppConstants.demoOtp}');
    }

    // ✅ In real app: call backend API to verify OTP & get user
    return UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      mobile: mobile,
      name: 'PayEase User',
      email: 'user@payease.in',
      kycStatus: 'NONE',
      isPinSet: false,
    );
  }
}