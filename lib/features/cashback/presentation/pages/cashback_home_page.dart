import 'package:flutter/material.dart';

import '../../../../core/widgets/empty_state.dart';

class CashbackHomePage extends StatelessWidget {
  const CashbackHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cashback')),
      body: const EmptyState(
        icon: Icons.local_offer_rounded,
        title: 'Cashback Engine',
        message: 'Coming in Phase 6',
      ),
    );
  }
}