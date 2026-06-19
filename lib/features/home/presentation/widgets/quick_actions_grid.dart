import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/extensions/context_extensions.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickAction(
        icon: Icons.qr_code_scanner_rounded,
        label: 'Scan & Pay',
        color: AppColors.primary,
      ),
      _QuickAction(
        icon: Icons.send_rounded,
        label: 'To Mobile',
        color: AppColors.secondary,
      ),
      _QuickAction(
        icon: Icons.account_balance_rounded,
        label: 'To Bank',
        color: AppColors.info,
      ),
      _QuickAction(
        icon: Icons.receipt_long_rounded,
        label: 'Pay Bills',
        color: AppColors.tertiary,
      ),
      _QuickAction(
        icon: Icons.smartphone_rounded,
        label: 'Recharge',
        color: AppColors.success,
      ),
      _QuickAction(
        icon: Icons.local_offer_rounded,
        label: 'Offers',
        color: AppColors.warning,
      ),
      _QuickAction(
        icon: Icons.contact_phone_rounded,
        label: 'Contacts',
        color: AppColors.bronze,
      ),
      _QuickAction(
        icon: Icons.more_horiz_rounded,
        label: 'More',
        color: AppColors.onSurfaceVariant,
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(AppSizes.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        border: Border.all(color: AppColors.outlineVariant, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.flash_on_rounded,
                color: context.colors.primary,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                'Quick Actions',
                style: context.textStyles.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.lg),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            mainAxisSpacing: AppSizes.lg,
            crossAxisSpacing: AppSizes.sm,
            childAspectRatio: 0.85,
            children: actions
                .map((a) => _QuickActionTile(action: a))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _QuickAction {
  final IconData icon;
  final String label;
  final Color color;

  _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
  });
}

class _QuickActionTile extends StatelessWidget {
  final _QuickAction action;

  const _QuickActionTile({required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: action.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            child: Icon(action.icon, color: action.color, size: 24),
          ),
          const SizedBox(height: 6),
          Text(
            action.label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.textStyles.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}