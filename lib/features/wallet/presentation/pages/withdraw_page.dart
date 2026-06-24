import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/route_names.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../service_locator.dart';
import '../bloc/wallet_bloc.dart';
import '../bloc/wallet_event.dart';
import '../bloc/wallet_state.dart';
import '../widgets/amount_input_card.dart';
import '../widgets/quick_amount_chips.dart';

class WithdrawPage extends StatelessWidget {
  const WithdrawPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<WalletBloc>(),
      child: const _WithdrawView(),
    );
  }
}

class _WithdrawView extends StatefulWidget {
  const _WithdrawView();

  @override
  State<_WithdrawView> createState() => _WithdrawViewState();
}

class _WithdrawViewState extends State<_WithdrawView> {
  final _amountCtrl = TextEditingController();

  @override
  void dispose() {
    _amountCtrl.dispose();
    super.dispose();
  }

  void _onWithdraw() {
    final amt = int.tryParse(_amountCtrl.text);
    if (amt == null || amt < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter valid amount')),
      );
      return;
    }

    context.read<WalletBloc>().add(WithdrawMoneyRequested(
          bankAccountId: 'bank_001',
          amount: amt * 100,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WalletBloc, WalletState>(
      listener: (context, state) {
        if (state is TransactionSuccess) {
          context.go(RouteNames.home);
          context.push(RouteNames.billReceipt, extra: {
            'amount': state.transaction.amount,
            'refId': state.transaction.referenceId,
            'title': 'Withdrawn Successfully!',
          });
        } else if (state is WalletError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBg,
        appBar: AppBar(
          title: const Text('Withdraw to Bank'),
          backgroundColor: AppColors.scaffoldBg,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Bank Card Demo
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: AppColors.blueGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.account_balance_rounded,
                        color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'HDFC Bank',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: AppColors.onSurface),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'XXXX XXXX 4587 · Default',
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.onSurfaceVariant,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  TextButton(onPressed: () {}, child: const Text('Change')),
                ],
              ),
            ),
            const SizedBox(height: 16),
            AmountInputCard(controller: _amountCtrl),
            const SizedBox(height: 16),
            QuickAmountChips(
              amounts: const [500, 1000, 2000, 5000, 10000],
              onSelected: (a) => setState(() => _amountCtrl.text = '$a'),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          color: Colors.white,
          child: BlocBuilder<WalletBloc, WalletState>(
            builder: (context, state) {
              final loading = state is TransactionProcessing;
              return SafeArea(
                top: false,
                child: SizedBox(
                  height: 56,
                  child: FilledButton.icon(
                    onPressed: loading ? null : _onWithdraw,
                    icon: loading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          )
                        : const Icon(Icons.account_balance_rounded, size: 18),
                    label: Text(loading ? 'Processing...' : 'Withdraw Now'),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}