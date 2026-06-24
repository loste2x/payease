import '../entities/wallet.dart';
import '../repositories/wallet_repository.dart';

class GetBalance {
  final WalletRepository repository;
  GetBalance(this.repository);

  Future<Wallet> call() => repository.getBalance();
}