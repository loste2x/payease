import 'package:equatable/equatable.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();
  @override
  List<Object?> get props => [];
}

class LoadWalletBalance extends WalletEvent {
  const LoadWalletBalance();
}

class AddMoneyRequested extends WalletEvent {
  final int amount;
  final String paymentMethod;
  const AddMoneyRequested({required this.amount, required this.paymentMethod});

  @override
  List<Object?> get props => [amount, paymentMethod];
}

class SendMoneyRequested extends WalletEvent {
  final String receiverMobile;
  final int amount;
  final String? note;
  const SendMoneyRequested({required this.receiverMobile, required this.amount, this.note});

  @override
  List<Object?> get props => [receiverMobile, amount, note];
}

class WithdrawMoneyRequested extends WalletEvent {
  final String bankAccountId;
  final int amount;
  const WithdrawMoneyRequested({required this.bankAccountId, required this.amount});

  @override
  List<Object?> get props => [bankAccountId, amount];
}