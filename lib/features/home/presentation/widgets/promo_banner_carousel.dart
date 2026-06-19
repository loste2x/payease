import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/extensions/context_extensions.dart';

class PromoBannerCarousel extends StatefulWidget {
  const PromoBannerCarousel({super.key});

  @override
  State<PromoBannerCarousel> createState() => _PromoBannerCarouselState();
}

class _PromoBannerCarouselState extends State<PromoBannerCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  final List<_PromoBanner> _banners = [
    _PromoBanner(
      title: 'Get ₹100 Cashback!',
      subtitle: 'On your first bill payment',
      tagText: 'FIRST100',
      icon: Icons.celebration_rounded,
      gradient: AppColors.cashbackGradient,
    ),
    _PromoBanner(
      title: 'Flat 10% Off',
      subtitle: 'On electricity bills, upto ₹50',
      tagText: 'ELEC50',
      icon: Icons.bolt_rounded,
      gradient: const LinearGradient(
        colors: [Color(0xFF11998E), Color(0xFF38EF7D)],
      ),
    ),
    _PromoBanner(
      title: 'Weekend Bonus',
      subtitle: '5% cashback on UPI payments',
      tagText: 'WEEKEND',
      icon: Icons.weekend_rounded,
      gradient: const LinearGradient(
        colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
      ),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                Icons.local_offer_rounded,
                color: AppColors.tertiary,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                'Offers for You',
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
        SizedBox(
          height: 130,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _banners.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
                child: _PromoBannerCard(banner: _banners[index]),
              );
            },
          ),
        ),
        const SizedBox(height: AppSizes.sm),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(_banners.length, (i) {
              final isActive = i == _currentPage;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 6,
                width: isActive ? 20 : 6,
                decoration: BoxDecoration(
                  color: isActive
                      ? context.colors.primary
                      : AppColors.outlineVariant,
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _PromoBanner {
  final String title;
  final String subtitle;
  final String tagText;
  final IconData icon;
  final Gradient gradient;

  _PromoBanner({
    required this.title,
    required this.subtitle,
    required this.tagText,
    required this.icon,
    required this.gradient,
  });
}

class _PromoBannerCard extends StatelessWidget {
  final _PromoBanner banner;

  const _PromoBannerCard({required this.banner});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: banner.gradient,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      padding: const EdgeInsets.all(AppSizes.lg),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            child: Icon(banner.icon, color: Colors.white, size: 30),
          ),
          const SizedBox(width: AppSizes.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    banner.tagText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  banner.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  banner.subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}