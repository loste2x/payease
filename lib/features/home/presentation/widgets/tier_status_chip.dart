import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class TierStatusChip extends StatelessWidget {
  final String tier; // BRONZE / SILVER / GOLD / PLATINUM

  const TierStatusChip({super.key, required this.tier});

  Color _color() {
    switch (tier.toUpperCase()) {
      case 'SILVER':
        return AppColors.silver;
      case 'GOLD':
        return AppColors.gold;
      case 'PLATINUM':
        return AppColors.platinum;
      case 'BRONZE':
      default:
        return AppColors.bronze;
    }
  }

  String _label() {
    return tier[0].toUpperCase() + tier.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final color = _color();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSizes.radiusFull),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.workspace_premium_rounded, size: 12, color: color),
          const SizedBox(width: 3),
          Text(
            _label(),
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}