import '../../domain/entities/wallet.dart';

class WalletModel extends Wallet {
  const WalletModel({
    required super.id,
    required super.userId,
    required super.balance,
    required super.dailyLimit,
    required super.monthlyLimit,
    super.dailySpent,
    super.monthlySpent,
    super.isActive,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      balance: json['balance'] as int,
      dailyLimit: json['daily_limit'] as int? ?? 2500000,
      monthlyLimit: json['monthly_limit'] as int? ?? 10000000,
      dailySpent: json['daily_spent'] as int? ?? 0,
      monthlySpent: json['monthly_spent'] as int? ?? 0,
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'balance': balance,
        'daily_limit': dailyLimit,
        'monthly_limit': monthlyLimit,
        'daily_spent': dailySpent,
        'monthly_spent': monthlySpent,
        'is_active': isActive,
      };
}