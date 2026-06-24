import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_money.dart';
import '../../domain/usecases/get_balance.dart';
import '../../domain/usecases/send_money.dart';
import '../../domain/usecases/withdraw_money.dart';
import 'wallet_event.dart';
import 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final GetBalance getBalance;
  final AddMoney addMoney;
  final SendMoney sendMoney;
  final WithdrawMoney withdrawMoney;

  WalletBloc({
    required this.getBalance,
    required this.addMoney,
    required this.sendMoney,
    required this.withdrawMoney,
  }) : super(const WalletInitial()) {
    on<LoadWalletBalance>(_onLoadBalance);
    on<AddMoneyRequested>(_onAddMoney);
    on<SendMoneyRequested>(_onSendMoney);
    on<WithdrawMoneyRequested>(_onWithdraw);
  }

  Future<void> _onLoadBalance(LoadWalletBalance event, Emitter<WalletState> emit) async {
    emit(const WalletLoading());
    try {
      final wallet = await getBalance();
      emit(WalletLoaded(wallet));
    } catch (e) {
      emit(WalletError(_clean(e)));
    }
  }

  Future<void> _onAddMoney(AddMoneyRequested event, Emitter<WalletState> emit) async {
    emit(const TransactionProcessing(message: 'Adding money...'));
    try {
      final txn = await addMoney(AddMoneyParams(
        amount: event.amount,
        paymentMethod: event.paymentMethod,
      ));
      emit(TransactionSuccess(txn));
    } catch (e) {
      emit(WalletError(_clean(e)));
    }
  }

  Future<void> _onSendMoney(SendMoneyRequested event, Emitter<WalletState> emit) async {
    emit(const TransactionProcessing(message: 'Sending money...'));
    try {
      final txn = await sendMoney(SendMoneyParams(
        receiverMobile: event.receiverMobile,
        amount: event.amount,
        note: event.note,
      ));
      emit(TransactionSuccess(txn));
    } catch (e) {
      emit(WalletError(_clean(e)));
    }
  }

  Future<void> _onWithdraw(WithdrawMoneyRequested event, Emitter<WalletState> emit) async {
    emit(const TransactionProcessing(message: 'Withdrawing...'));
    try {
      final txn = await withdrawMoney(WithdrawParams(
        bankAccountId: event.bankAccountId,
        amount: event.amount,
      ));
      emit(TransactionSuccess(txn));
    } catch (e) {
      emit(WalletError(_clean(e)));
    }
  }

  String _clean(Object e) => e.toString().replaceFirst('Exception: ', '');
}