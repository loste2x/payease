import 'package:flutter/material.dart';

import '../../../../core/widgets/empty_state.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: const EmptyState(
        icon: Icons.history_rounded,
        title: 'Transaction History',
        message: 'Coming in Phase 7',
      ),
    );
  }
}