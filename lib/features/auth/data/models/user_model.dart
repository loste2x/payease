import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.mobile,
    super.name,
    super.email,
    super.kycStatus,
    super.isPinSet,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      mobile: json['mobile'] as String,
      name: json['name'] as String?,
      email: json['email'] as String?,
      kycStatus: json['kyc_status'] as String? ?? 'NONE',
      isPinSet: json['is_pin_set'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mobile': mobile,
      'name': name,
      'email': email,
      'kyc_status': kycStatus,
      'is_pin_set': isPinSet,
    };
  }
}