import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/route_names.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PayEase'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () => context.go(RouteNames.login),
          ),
          const SizedBox(width: AppSizes.sm),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppSizes.maxContentWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSizes.lg),

                  // Welcome card
                  Container(
                    padding: const EdgeInsets.all(AppSizes.xl),
                    decoration: BoxDecoration(
                      gradient: AppColors.walletGradient,
                      borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.indigo.withValues(alpha: 0.25),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.check_circle_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                            const SizedBox(width: AppSizes.sm),
                            Text(
                              'Login Successful!',
                              style: context.textStyles.titleLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.md),
                        Text(
                          'Welcome to PayEase 🎉\nYour journey to easy payments starts here.',
                          style: context.textStyles.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: AppSizes.lg),
                        Text(
                          'Phase 2 Complete ✅',
                          style: context.textStyles.titleSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSizes.xxl),

                  // Coming Soon section
                  Text(
                    'Coming Soon',
                    style: context.textStyles.titleMedium,
                  ),

                  const SizedBox(height: AppSizes.md),

                  // Feature cards (placeholders)
                  _FeatureTile(
                    icon: Icons.account_balance_wallet_rounded,
                    title: 'Wallet',
                    subtitle: 'Add money, send & receive',
                    color: AppColors.primary,
                  ),
                  _FeatureTile(
                    icon: Icons.receipt_long_rounded,
                    title: 'Bill Payments',
                    subtitle: 'Electricity, Mobile, DTH & more',
                    color: AppColors.secondary,
                  ),
                  _FeatureTile(
                    icon: Icons.local_offer_rounded,
                    title: 'Cashback Engine',
                    subtitle: 'Earn rewards on every payment',
                    color: AppColors.tertiary,
                  ),
                  _FeatureTile(
                    icon: Icons.verified_user_rounded,
                    title: 'KYC Verification',
                    subtitle: 'Aadhaar + PAN verification',
                    color: AppColors.info,
                  ),

                  const SizedBox(height: AppSizes.xxl),

                  // Logout button
                  CustomButton(
                    label: 'Logout',
                    type: ButtonType.outline,
                    icon: Icons.logout_rounded,
                    onPressed: () => context.go(RouteNames.login),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.md),
      padding: const EdgeInsets.all(AppSizes.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        border: Border.all(color: AppColors.outlineVariant, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: AppSizes.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textStyles.titleMedium,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: context.textStyles.bodySmall,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(AppSizes.radiusFull),
            ),
            child: Text(
              'Soon',
              style: context.textStyles.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}