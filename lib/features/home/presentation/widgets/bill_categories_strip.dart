import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class BillCategoriesStrip extends StatelessWidget {
  const BillCategoriesStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      _Cat(Icons.bolt_rounded, 'Electricity', const Color(0xFFFF9800)),
      _Cat(Icons.smartphone_rounded, 'Mobile', const Color(0xFF4CAF50)),
      _Cat(Icons.tv_rounded, 'DTH', const Color(0xFF9C27B0)),
      _Cat(Icons.wifi_rounded, 'Broadband', const Color(0xFF00BCD4)),
      _Cat(Icons.local_fire_department_rounded, 'Gas', const Color(0xFFFF5722)),
      _Cat(Icons.water_drop_rounded, 'Water', const Color(0xFF03A9F4)),
      _Cat(Icons.credit_card_rounded, 'Credit', const Color(0xFFE91E63)),
      _Cat(Icons.car_rental_rounded, 'FASTag', const Color(0xFFCDDC39)),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '🧾 Recharge & Pay Bills',
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
                child: const Text(
                  'See All',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 12,
              childAspectRatio: 0.9,
            ),
            itemCount: categories.length,
            itemBuilder: (_, i) => _CatTile(cat: categories[i]),
          ),
        ],
      ),
    );
  }
}

class _Cat {
  final IconData icon;
  final String label;
  final Color color;
  _Cat(this.icon, this.label, this.color);
}

class _CatTile extends StatelessWidget {
  final _Cat cat;
  const _CatTile({required this.cat});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: cat.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(cat.icon, color: cat.color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            cat.label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}