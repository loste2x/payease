import '../entities/transaction.dart';
import '../repositories/wallet_repository.dart';

class WithdrawParams {
  final String bankAccountId;
  final int amount;
  const WithdrawParams({required this.bankAccountId, required this.amount});
}

class WithdrawMoney {
  final WalletRepository repository;
  WithdrawMoney(this.repository);

  Future<Transaction> call(WithdrawParams p) =>
      repository.withdrawMoney(bankAccountId: p.bankAccountId, amount: p.amount);
}