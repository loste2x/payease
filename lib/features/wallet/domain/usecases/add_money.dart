import '../entities/transaction.dart';
import '../repositories/wallet_repository.dart';

class AddMoneyParams {
  final int amount;
  final String paymentMethod;
  const AddMoneyParams({required this.amount, required this.paymentMethod});
}

class AddMoney {
  final WalletRepository repository;
  AddMoney(this.repository);

  Future<Transaction> call(AddMoneyParams p) =>
      repository.addMoney(amount: p.amount, paymentMethod: p.paymentMethod);
}