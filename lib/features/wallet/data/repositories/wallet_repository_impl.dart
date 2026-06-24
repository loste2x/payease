import '../../domain/entities/transaction.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../datasources/wallet_remote_datasource.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource remoteDataSource;
  WalletRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Wallet> getBalance() => remoteDataSource.getBalance();

  @override
  Future<List<Transaction>> getRecentTransactions({int limit = 10}) =>
      remoteDataSource.getRecentTransactions(limit: limit);

  @override
  Future<Transaction> addMoney({required int amount, required String paymentMethod}) =>
      remoteDataSource.addMoney(amount: amount, paymentMethod: paymentMethod);

  @override
  Future<Transaction> sendMoney({
    required String receiverMobile,
    required int amount,
    String? note,
  }) =>
      remoteDataSource.sendMoney(
        receiverMobile: receiverMobile,
        amount: amount,
        note: note,
      );

  @override
  Future<Transaction> withdrawMoney({
    required String bankAccountId,
    required int amount,
  }) =>
      remoteDataSource.withdrawMoney(bankAccountId: bankAccountId, amount: amount);
}