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
import '../widgets/payment_method_tile.dart';
import '../widgets/quick_amount_chips.dart';

class AddMoneyPage extends StatelessWidget {
  const AddMoneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<WalletBloc>(),
      child: const _AddMoneyView(),
    );
  }
}

class _AddMoneyView extends StatefulWidget {
  const _AddMoneyView();

  @override
  State<_AddMoneyView> createState() => _AddMoneyViewState();
}

class _AddMoneyViewState extends State<_AddMoneyView> {
  final _amountCtrl = TextEditingController();
  String _selected = 'UPI';

  @override
  void dispose() {
    _amountCtrl.dispose();
    super.dispose();
  }

  void _onPay() {
    final amt = int.tryParse(_amountCtrl.text);
    if (amt == null || amt < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter valid amount')),
      );
      return;
    }
    if (amt > 10000) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maximum ₹10,000 per transaction')),
      );
      return;
    }

    context.read<WalletBloc>().add(AddMoneyRequested(
          amount: amt * 100,
          paymentMethod: _selected,
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
            'title': 'Money Added Successfully!',
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
          title: const Text('Add Money'),
          backgroundColor: AppColors.scaffoldBg,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              AmountInputCard(controller: _amountCtrl),
              const SizedBox(height: 16),
              QuickAmountChips(
                onSelected: (amt) => setState(() => _amountCtrl.text = '$amt'),
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  'Pay using',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              PaymentMethodTile(
                icon: Icons.account_balance_wallet_rounded,
                label: 'UPI',
                subtitle: '₹0 convenience fee',
                iconColor: AppColors.primary,
                isRecommended: true,
                isSelected: _selected == 'UPI',
                onTap: () => setState(() => _selected = 'UPI'),
              ),
              const SizedBox(height: 10),
              PaymentMethodTile(
                icon: Icons.credit_card_rounded,
                label: 'Debit / Credit Card',
                subtitle: '₹0 convenience fee',
                iconColor: AppColors.info,
                isSelected: _selected == 'CARD',
                onTap: () => setState(() => _selected = 'CARD'),
              ),
              const SizedBox(height: 10),
              PaymentMethodTile(
                icon: Icons.account_balance_rounded,
                label: 'Net Banking',
                subtitle: 'All major banks supported',
                iconColor: AppColors.success,
                isSelected: _selected == 'NETBANKING',
                onTap: () => setState(() => _selected = 'NETBANKING'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, -4)),
            ],
          ),
          child: BlocBuilder<WalletBloc, WalletState>(
            builder: (context, state) {
              final loading = state is TransactionProcessing;
              return SafeArea(
                top: false,
                child: SizedBox(
                  height: 56,
                  child: FilledButton.icon(
                    onPressed: loading ? null : _onPay,
                    icon: loading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          )
                        : const Icon(Icons.lock_rounded, size: 18),
                    label: Text(loading ? 'Processing...' : 'Pay Securely'),
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