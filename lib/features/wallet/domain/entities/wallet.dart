import 'package:equatable/equatable.dart';

class Wallet extends Equatable {
  final String id;
  final String userId;
  final int balance; // In paisa
  final int dailyLimit;
  final int monthlyLimit;
  final int dailySpent;
  final int monthlySpent;
  final bool isActive;

  const Wallet({
    required this.id,
    required this.userId,
    required this.balance,
    required this.dailyLimit,
    required this.monthlyLimit,
    this.dailySpent = 0,
    this.monthlySpent = 0,
    this.isActive = true,
  });

  int get availableDaily => dailyLimit - dailySpent;
  int get availableMonthly => monthlyLimit - monthlySpent;

  @override
  List<Object?> get props =>
      [id, userId, balance, dailyLimit, monthlyLimit, dailySpent, monthlySpent, isActive];
}