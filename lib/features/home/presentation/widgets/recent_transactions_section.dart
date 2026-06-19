import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/utils/formatters.dart';

class RecentTransactionsSection extends StatelessWidget {
  const RecentTransactionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = _demoTransactions();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSizes.lg,
            0,
            AppSizes.lg,
            AppSizes.md,
          ),
          child: Row(
            children: [
              Icon(
                Icons.history_rounded,
                color: context.colors.primary,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                'Recent Activity',
                style: context.textStyles.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('See All'),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            border: Border.all(color: AppColors.outlineVariant, width: 1),
          ),
          child: Column(
            children: List.generate(transactions.length, (index) {
              final isLast = index == transactions.length - 1;
              return _TransactionTile(
                transaction: transactions[index],
                showDivider: !isLast,
              );
            }),
          ),
        ),
      ],
    );
  }

  List<_TxData> _demoTransactions() {
    return [
      _TxData(
        icon: Icons.bolt_rounded,
        title: 'Electricity Bill',
        subtitle: 'DGVCL · Today, 10:24 AM',
        amount: -85000,
        iconColor: const Color(0xFFFF9800),
        isCashback: true,
        cashbackAmount: 5000,
      ),
      _TxData(
        icon: Icons.arrow_downward_rounded,
        title: 'Money Received',
        subtitle: 'From Rahul · Yesterday, 8:15 PM',
        amount: 50000,
        iconColor: AppColors.success,
      ),
      _TxData(
        icon: Icons.smartphone_rounded,
        title: 'Mobile Recharge',
        subtitle: 'Jio · Yesterday, 11:30 AM',
        amount: -29900,
        iconColor: const Color(0xFF4CAF50),
        isCashback: true,
        cashbackAmount: 1500,
      ),
      _TxData(
        icon: Icons.add_circle_rounded,
        title: 'Money Added',
        subtitle: 'From HDFC Bank · 2 days ago',
        amount: 100000,
        iconColor: AppColors.info,
      ),
    ];
  }
}

class _TxData {
  final IconData icon;
  final String title;
  final String subtitle;
  final int amount; // paisa, negative = debit, positive = credit
  final Color iconColor;
  final bool isCashback;
  final int cashbackAmount;

  _TxData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.iconColor,
    this.isCashback = false,
    this.cashbackAmount = 0,
  });
}

class _TransactionTile extends StatelessWidget {
  final _TxData transaction;
  final bool showDivider;

  const _TransactionTile({
    required this.transaction,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    final isDebit = transaction.amount < 0;
    final amount = transaction.amount.abs();

    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: transaction.iconColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                  child: Icon(
                    transaction.icon,
                    color: transaction.iconColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: AppSizes.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.title,
                        style: context.textStyles.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        transaction.subtitle,
                        style: context.textStyles.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSizes.sm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${isDebit ? '-' : '+'} ${Formatters.currency(amount)}',
                      style: TextStyle(
                        color: isDebit ? AppColors.error : AppColors.success,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (transaction.isCashback) ...[
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.tertiaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '+${Formatters.currency(transaction.cashbackAmount)} CB',
                          style: const TextStyle(
                            color: AppColors.tertiary,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
            child: Divider(height: 1, color: AppColors.divider),
          ),
      ],
    );
  }
}