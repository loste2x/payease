import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/extensions/context_extensions.dart';
import 'tier_status_chip.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.lg,
        AppSizes.md,
        AppSizes.lg,
        AppSizes.lg,
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'P',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSizes.md),

          // Greeting + Name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _greeting(),
                  style: context.textStyles.bodySmall,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'PayEase User',
                        overflow: TextOverflow.ellipsis,
                        style: context.textStyles.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.sm),
                    const TierStatusChip(tier: 'BRONZE'),
                  ],
                ),
              ],
            ),
          ),

          // Notifications
          _IconButton(
            icon: Icons.notifications_outlined,
            badgeCount: 3,
            onTap: () {},
          ),
          const SizedBox(width: AppSizes.xs),

          // QR Scanner
          _IconButton(
            icon: Icons.qr_code_scanner_rounded,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning ☀️';
    if (hour < 17) return 'Good Afternoon 👋';
    return 'Good Evening 🌙';
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final int? badgeCount;

  const _IconButton({
    required this.icon,
    required this.onTap,
    this.badgeCount,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(AppSizes.radiusFull),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppSizes.radiusFull),
            child: Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 22,
                color: context.colors.onSurface,
              ),
            ),
          ),
        ),
        if (badgeCount != null && badgeCount! > 0)
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.scaffoldBg, width: 2),
              ),
              child: Text(
                '$badgeCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }
}