import 'package:equatable/equatable.dart';

enum TxnType { credit, debit }

enum TxnCategory {
  addMoney,
  send,
  receive,
  withdraw,
  billPayment,
  cashback,
  refund,
}

enum TxnStatus { pending, processing, success, failed, refunded }

class Transaction extends Equatable {
  final String id;
  final String referenceId;
  final TxnType type;
  final TxnCategory category;
  final int amount;
  final int? balanceAfter;
  final String? paymentMethod;
  final String description;
  final TxnStatus status;
  final DateTime createdAt;
  final String? receiverName;
  final int? cashbackAmount;

  const Transaction({
    required this.id,
    required this.referenceId,
    required this.type,
    required this.category,
    required this.amount,
    this.balanceAfter,
    this.paymentMethod,
    required this.description,
    required this.status,
    required this.createdAt,
    this.receiverName,
    this.cashbackAmount,
  });

  bool get isCredit => type == TxnType.credit;
  bool get isDebit => type == TxnType.debit;
  bool get hasCashback => cashbackAmount != null && cashbackAmount! > 0;

  @override
  List<Object?> get props => [
        id,
        referenceId,
        type,
        category,
        amount,
        balanceAfter,
        paymentMethod,
        description,
        status,
        createdAt,
        receiverName,
        cashbackAmount,
      ];
}