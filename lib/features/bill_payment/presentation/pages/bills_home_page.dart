import 'package:flutter/material.dart';

import '../../../../core/widgets/empty_state.dart';

class BillsHomePage extends StatelessWidget {
  const BillsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pay Bills')),
      body: const EmptyState(
        icon: Icons.receipt_long_rounded,
        title: 'Bill Payments',
        message: 'BBPS integration coming in Phase 5',
      ),
    );
  }
}