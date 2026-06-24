import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class QuickAmountChips extends StatelessWidget {
  final List<int> amounts;
  final ValueChanged<int> onSelected;

  const QuickAmountChips({
    super.key,
    this.amounts = const [100, 500, 1000, 2000, 5000],
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: amounts.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          final amt = amounts[i];
          return Material(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: const BorderSide(color: AppColors.outlineVariant),
            ),
            child: InkWell(
              onTap: () => onSelected(amt),
              borderRadius: BorderRadius.circular(24),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: Text(
                  '₹$amt',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurface,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}