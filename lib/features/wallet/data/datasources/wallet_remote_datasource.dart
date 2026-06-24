import '../../domain/entities/transaction.dart';
import '../models/transaction_model.dart';
import '../models/wallet_model.dart';

abstract class WalletRemoteDataSource {
  Future<WalletModel> getBalance();
  Future<List<TransactionModel>> getRecentTransactions({int limit});
  Future<TransactionModel> addMoney({required int amount, required String paymentMethod});
  Future<TransactionModel> sendMoney({required String receiverMobile, required int amount, String? note});
  Future<TransactionModel> withdrawMoney({required String bankAccountId, required int amount});
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  // In-memory demo state
  int _balance = 1245075; // ₹12,450.75
  final List<TransactionModel> _txns = [];

  @override
  Future<WalletModel> getBalance() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return WalletModel(
      id: 'wallet_001',
      userId: 'user_001',
      balance: _balance,
      dailyLimit: 2500000,
      monthlyLimit: 10000000,
    );
  }

  @override
  Future<List<TransactionModel>> getRecentTransactions({int limit = 10}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _txns.take(limit).toList();
  }

  @override
  Future<TransactionModel> addMoney({required int amount, required String paymentMethod}) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    if (amount < 100) throw Exception('Minimum amount is ₹1');
    if (amount > 1000000) throw Exception('Maximum amount is ₹10,000');

    _balance += amount;
    final txn = TransactionModel(
      id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
      referenceId: 'PE-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
      type: TxnType.credit,
      category: TxnCategory.addMoney,
      amount: amount,
      balanceAfter: _balance,
      paymentMethod: paymentMethod,
      description: 'Money added via $paymentMethod',
      status: TxnStatus.success,
      createdAt: DateTime.now(),
    );
    _txns.insert(0, txn);
    return txn;
  }

  @override
  Future<TransactionModel> sendMoney({
    required String receiverMobile,
    required int amount,
    String? note,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    if (amount > _balance) throw Exception('Insufficient balance');
    if (receiverMobile.length != 10) throw Exception('Enter valid 10-digit mobile');

    _balance -= amount;
    final txn = TransactionModel(
      id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
      referenceId: 'PE-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
      type: TxnType.debit,
      category: TxnCategory.send,
      amount: amount,
      balanceAfter: _balance,
      paymentMethod: 'WALLET',
      description: note ?? 'Money sent',
      status: TxnStatus.success,
      createdAt: DateTime.now(),
      receiverName: '+91 $receiverMobile',
    );
    _txns.insert(0, txn);
    return txn;
  }

  @override
  Future<TransactionModel> withdrawMoney({
    required String bankAccountId,
    required int amount,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    if (amount > _balance) throw Exception('Insufficient balance');

    _balance -= amount;
    final txn = TransactionModel(
      id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
      referenceId: 'PE-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
      type: TxnType.debit,
      category: TxnCategory.withdraw,
      amount: amount,
      balanceAfter: _balance,
      paymentMethod: 'BANK',
      description: 'Withdrawn to bank',
      status: TxnStatus.success,
      createdAt: DateTime.now(),
    );
    _txns.insert(0, txn);
    return txn;
  }
}