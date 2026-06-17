class AppConstants {
  AppConstants._();

  // OTP
  static const int otpLength = 6;
  static const int otpTimerSeconds = 30;
  static const int mobileLength = 10;
  static const int pinLength = 4;

  // Pagination
  static const int defaultPageSize = 20;

  // Cache
  static const Duration cacheExpiry = Duration(hours: 24);

  // API Timeouts
  static const Duration connectionTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);

  // Demo
  static const String demoOtp = '123456';
  static const String demoMobile = '9999999999';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String onboardingKey = 'onboarding_done';

  // Wallet Limits (in paisa — divide by 100 for rupees)
  static const int defaultDailyLimit = 2500000; // ₹25,000
  static const int defaultMonthlyLimit = 10000000; // ₹1,00,000
  static const int defaultPerTxnLimit = 1000000; // ₹10,000
}