import '../entities/transaction.dart';
import '../entities/wallet.dart';

abstract class WalletRepository {
  Future<Wallet> getBalance();
  Future<List<Transaction>> getRecentTransactions({int limit = 10});

  Future<Transaction> addMoney({
    required int amount,
    required String paymentMethod,
  });

  Future<Transaction> sendMoney({
    required String receiverMobile,
    required int amount,
    String? note,
  });

  Future<Transaction> withdrawMoney({
    required String bankAccountId,
    required int amount,
  });
}