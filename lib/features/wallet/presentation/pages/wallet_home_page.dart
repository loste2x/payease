import 'package:flutter/material.dart';

import '../../../../core/widgets/empty_state.dart';

class WalletHomePage extends StatelessWidget {
  const WalletHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wallet')),
      body: const EmptyState(
        icon: Icons.account_balance_wallet_rounded,
        title: 'Wallet Coming Soon',
        message: 'This module will be built in Phase 4',
      ),
    );
  }
}