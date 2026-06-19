import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/extensions/context_extensions.dart';

class BillCategoriesStrip extends StatelessWidget {
  const BillCategoriesStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      _BillCategory(icon: Icons.bolt_rounded, label: 'Electricity', color: const Color(0xFFFF9800)),
      _BillCategory(icon: Icons.smartphone_rounded, label: 'Mobile', color: const Color(0xFF4CAF50)),
      _BillCategory(icon: Icons.tv_rounded, label: 'DTH', color: const Color(0xFF9C27B0)),
      _BillCategory(icon: Icons.wifi_rounded, label: 'Broadband', color: const Color(0xFF00BCD4)),
      _BillCategory(icon: Icons.local_fire_department_rounded, label: 'Gas', color: const Color(0xFFFF5722)),
      _BillCategory(icon: Icons.water_drop_rounded, label: 'Water', color: const Color(0xFF03A9F4)),
      _BillCategory(icon: Icons.credit_card_rounded, label: 'Credit Card', color: const Color(0xFFF44336)),
      _BillCategory(icon: Icons.car_rental_rounded, label: 'FASTag', color: const Color(0xFFCDDC39)),
    ];

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
                Icons.receipt_long_rounded,
                color: context.colors.primary,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                'Pay Bills',
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
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 96,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSizes.md),
            itemBuilder: (context, index) {
              return _CategoryItem(category: categories[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _BillCategory {
  final IconData icon;
  final String label;
  final Color color;

  _BillCategory({
    required this.icon,
    required this.label,
    required this.color,
  });
}

class _CategoryItem extends StatelessWidget {
  final _BillCategory category;

  const _CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      child: SizedBox(
        width: 72,
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: category.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              ),
              child: Icon(category.icon, color: category.color, size: 28),
            ),
            const SizedBox(height: 6),
            Text(
              category.label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.textStyles.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}