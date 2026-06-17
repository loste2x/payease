class Validators {
  Validators._();

  /// Mobile number validation (10 digit Indian)
  static String? mobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }
    if (value.length != 10) {
      return 'Enter valid 10-digit mobile number';
    }
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
      return 'Enter valid Indian mobile number';
    }
    return null;
  }

  /// OTP validation (6 digit)
  static String? otp(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }
    if (value.length != 6) {
      return 'Enter 6-digit OTP';
    }
    if (!RegExp(r'^\d{6}$').hasMatch(value)) {
      return 'OTP must contain only digits';
    }
    return null;
  }

  /// PIN validation (4 digit)
  static String? pin(String? value) {
    if (value == null || value.isEmpty) {
      return 'PIN is required';
    }
    if (value.length != 4) {
      return 'PIN must be 4 digits';
    }
    return null;
  }

  /// Email validation
  static String? email(String? value) {
    if (value == null || value.isEmpty) return null;
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!regex.hasMatch(value)) {
      return 'Enter valid email';
    }
    return null;
  }

  /// Aadhaar validation (12 digit)
  static String? aadhaar(String? value) {
    if (value == null || value.isEmpty) {
      return 'Aadhaar number is required';
    }
    if (value.length != 12) {
      return 'Aadhaar must be 12 digits';
    }
    return null;
  }

  /// PAN validation (ABCDE1234F)
  static String? pan(String? value) {
    if (value == null || value.isEmpty) {
      return 'PAN is required';
    }
    if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$').hasMatch(value.toUpperCase())) {
      return 'Enter valid PAN (e.g., ABCDE1234F)';
    }
    return null;
  }

  /// IFSC validation
  static String? ifsc(String? value) {
    if (value == null || value.isEmpty) {
      return 'IFSC is required';
    }
    if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(value.toUpperCase())) {
      return 'Enter valid IFSC code';
    }
    return null;
  }

  /// Amount validation
  static String? amount(String? value, {double min = 1, double max = 100000}) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }
    final amt = double.tryParse(value);
    if (amt == null) return 'Enter valid amount';
    if (amt < min) return 'Minimum amount is ₹$min';
    if (amt > max) return 'Maximum amount is ₹$max';
    return null;
  }

  /// Required field
  static String? required(String? value, [String fieldName = 'This field']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }
}