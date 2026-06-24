import '../entities/transaction.dart';
import '../repositories/wallet_repository.dart';

class SendMoneyParams {
  final String receiverMobile;
  final int amount;
  final String? note;
  const SendMoneyParams({required this.receiverMobile, required this.amount, this.note});
}

class SendMoney {
  final WalletRepository repository;
  SendMoney(this.repository);

  Future<Transaction> call(SendMoneyParams p) => repository.sendMoney(
        receiverMobile: p.receiverMobile,
        amount: p.amount,
        note: p.note,
      );
}