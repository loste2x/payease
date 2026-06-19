import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

enum StatusType { success, error, warning, info, pending }

class StatusChip extends StatelessWidget {
  final String label;
  final StatusType type;
  final IconData? icon;

  const StatusChip({
    super.key,
    required this.label,
    required this.type,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color fgColor;
    IconData defaultIcon;

    switch (type) {
      case StatusType.success:
        bgColor = AppColors.successContainer;
        fgColor = AppColors.success;
        defaultIcon = Icons.check_circle;
        break;
      case StatusType.error:
        bgColor = AppColors.errorContainer;
        fgColor = AppColors.error;
        defaultIcon = Icons.error;
        break;
      case StatusType.warning:
        bgColor = AppColors.warningContainer;
        fgColor = AppColors.warning;
        defaultIcon = Icons.warning_rounded;
        break;
      case StatusType.info:
        bgColor = AppColors.infoContainer;
        fgColor = AppColors.info;
        defaultIcon = Icons.info;
        break;
      case StatusType.pending:
        bgColor = AppColors.surfaceContainerHigh;
        fgColor = AppColors.onSurfaceVariant;
        defaultIcon = Icons.schedule;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon ?? defaultIcon, size: 14, color: fgColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: fgColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
