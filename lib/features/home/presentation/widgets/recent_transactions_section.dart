import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/formatters.dart';

class RecentTransactionsSection extends StatelessWidget {
  const RecentTransactionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final txns = _demo();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Row(
              children: [
                const Text(
                  '📊 Recent Activity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.onSurface,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    minimumSize: Size.zero,
                    foregroundColor: AppColors.primary,
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'View All',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                      ),
                      Icon(Icons.arrow_forward_rounded, size: 14),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ...List.generate(txns.length, (i) {
            return _Tile(
              tx: txns[i],
              showDivider: i != txns.length - 1,
            );
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  List<_Tx> _demo() => [
        _Tx(Icons.bolt_rounded, 'Electricity Bill', 'DGVCL · Today, 10:24 AM',
            -85000, const Color(0xFFFF9800), true, 5000),
        _Tx(Icons.arrow_downward_rounded, 'Money Received', 'From Rahul · Yesterday',
            50000, AppColors.success, false, 0),
        _Tx(Icons.smartphone_rounded, 'Mobile Recharge', 'Jio · Yesterday',
            -29900, const Color(0xFF4CAF50), true, 1500),
        _Tx(Icons.add_circle_rounded, 'Money Added', 'From HDFC Bank · 2 days ago',
            100000, AppColors.info, false, 0),
      ];
}

class _Tx {
  final IconData icon;
  final String title;
  final String subtitle;
  final int amount;
  final Color color;
  final bool hasCashback;
  final int cashback;

  _Tx(this.icon, this.title, this.subtitle, this.amount, this.color, this.hasCashback, this.cashback);
}

class _Tile extends StatelessWidget {
  final _Tx tx;
  final bool showDivider;

  const _Tile({required this.tx, required this.showDivider});

  @override
  Widget build(BuildContext context) {
    final isDebit = tx.amount < 0;
    final amt = tx.amount.abs();

    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: tx.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(tx.icon, color: tx.color, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tx.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        tx.subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${isDebit ? '-' : '+'} ${Formatters.currency(amt)}',
                      style: TextStyle(
                        color: isDebit ? AppColors.error : AppColors.success,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (tx.hasCashback) ...[
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          gradient: AppColors.cashbackGradient,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '+${Formatters.currency(tx.cashback)} CB',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(height: 1, color: AppColors.divider),
          ),
      ],
    );
  }
}