import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/utils/formatters.dart';

class WalletBalanceCard extends StatefulWidget {
  const WalletBalanceCard({super.key});

  @override
  State<WalletBalanceCard> createState() => _WalletBalanceCardState();
}

class _WalletBalanceCardState extends State<WalletBalanceCard> {
  bool _showBalance = true;

  // Demo balance: ₹12,450.75 stored in paisa
  final int _balanceInPaisa = 1245075;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.xl),
      decoration: BoxDecoration(
        gradient: AppColors.walletGradient,
        borderRadius: BorderRadius.circular(AppSizes.radiusXl),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3949AB).withValues(alpha: 0.25),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSizes.sm),
              Text(
                'PayEase Wallet',
                style: context.textStyles.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  _showBalance ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () {
                  setState(() => _showBalance = !_showBalance);
                },
              ),
            ],
          ),
          const SizedBox(height: AppSizes.lg),

          // Balance Amount
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _showBalance
                    ? Formatters.currency(_balanceInPaisa)
                    : '₹ ••••••',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSizes.xs),

          Text(
            'Available Balance',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: AppSizes.xl),

          // Action Buttons Row
          Row(
            children: [
              Expanded(
                child: _ActionChip(
                  icon: Icons.add_rounded,
                  label: 'Add Money',
                  onTap: () {},
                ),
              ),
              const SizedBox(width: AppSizes.sm),
              Expanded(
                child: _ActionChip(
                  icon: Icons.arrow_outward_rounded,
                  label: 'Send',
                  onTap: () {},
                ),
              ),
              const SizedBox(width: AppSizes.sm),
              Expanded(
                child: _ActionChip(
                  icon: Icons.account_balance_rounded,
                  label: 'Withdraw',
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            children: [
              Icon(icon, color: Colors.white, size: 22),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}