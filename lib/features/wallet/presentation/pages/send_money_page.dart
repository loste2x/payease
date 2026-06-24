import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class SendMoneyPage extends StatelessWidget {
  const SendMoneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<WalletBloc>(),
      child: const _SendMoneyView(),
    );
  }
}

class _SendMoneyView extends StatefulWidget {
  const _SendMoneyView();

  @override
  State<_SendMoneyView> createState() => _SendMoneyViewState();
}

class _SendMoneyViewState extends State<_SendMoneyView> {
  final _mobileCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();

  @override
  void dispose() {
    _mobileCtrl.dispose();
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  void _onSend() {
    final amt = int.tryParse(_amountCtrl.text);
    if (_mobileCtrl.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter valid 10-digit mobile')),
      );
      return;
    }
    if (amt == null || amt < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter valid amount')),
      );
      return;
    }

    context.read<WalletBloc>().add(SendMoneyRequested(
          receiverMobile: _mobileCtrl.text,
          amount: amt * 100,
          note: _noteCtrl.text.trim(),
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
            'title': 'Money Sent Successfully!',
            'receiver': state.transaction.receiverName,
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
          title: const Text('Send Money'),
          backgroundColor: AppColors.scaffoldBg,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Mobile input
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Receiver's Mobile Number",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _mobileCtrl,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                    decoration: const InputDecoration(
                      counterText: '',
                      prefixText: '+91 ',
                      hintText: '9876543210',
                      filled: false,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            AmountInputCard(controller: _amountCtrl),
            const SizedBox(height: 16),
            QuickAmountChips(
              onSelected: (amt) => setState(() => _amountCtrl.text = '$amt'),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _noteCtrl,
                maxLength: 50,
                decoration: const InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false,
                  hintText: 'Add a note (optional)',
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
              ),
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
                    onPressed: loading ? null : _onSend,
                    icon: loading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          )
                        : const Icon(Icons.arrow_outward_rounded, size: 18),
                    label: Text(loading ? 'Sending...' : 'Send Money'),
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