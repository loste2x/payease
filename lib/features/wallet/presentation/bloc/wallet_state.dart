import 'package:equatable/equatable.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/wallet.dart';

abstract class WalletState extends Equatable {
  const WalletState();
  @override
  List<Object?> get props => [];
}

class WalletInitial extends WalletState {
  const WalletInitial();
}

class WalletLoading extends WalletState {
  const WalletLoading();
}

class WalletLoaded extends WalletState {
  final Wallet wallet;
  const WalletLoaded(this.wallet);

  @override
  List<Object?> get props => [wallet];
}

class TransactionProcessing extends WalletState {
  final String message;
  const TransactionProcessing({this.message = 'Processing...'});

  @override
  List<Object?> get props => [message];
}

class TransactionSuccess extends WalletState {
  final Transaction transaction;
  const TransactionSuccess(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class WalletError extends WalletState {
  final String message;
  const WalletError(this.message);

  @override
  List<Object?> get props => [message];
}