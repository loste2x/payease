import '../../domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  const TransactionModel({
    required super.id,
    required super.referenceId,
    required super.type,
    required super.category,
    required super.amount,
    super.balanceAfter,
    super.paymentMethod,
    required super.description,
    required super.status,
    required super.createdAt,
    super.receiverName,
    super.cashbackAmount,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      referenceId: json['reference_id'] as String,
      type: TxnType.values.firstWhere(
        (e) => e.name == (json['type'] as String).toLowerCase(),
        orElse: () => TxnType.debit,
      ),
      category: TxnCategory.values.firstWhere(
        (e) => e.name == (json['category'] as String).toLowerCase().replaceAll('_', ''),
        orElse: () => TxnCategory.addMoney,
      ),
      amount: json['amount'] as int,
      balanceAfter: json['balance_after'] as int?,
      paymentMethod: json['payment_method'] as String?,
      description: json['description'] as String? ?? '',
      status: TxnStatus.values.firstWhere(
        (e) => e.name == (json['status'] as String).toLowerCase(),
        orElse: () => TxnStatus.pending,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      receiverName: json['receiver_name'] as String?,
      cashbackAmount: json['cashback_amount'] as int?,
    );
  }
}