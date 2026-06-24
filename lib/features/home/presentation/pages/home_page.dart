import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../widgets/bill_categories_strip.dart';
import '../widgets/home_header.dart';
import '../widgets/promo_banner_carousel.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/recent_transactions_section.dart';
import '../widgets/wallet_balance_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 800));
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          slivers: const [
            // Hero dark section (Header + Wallet Card)
            SliverToBoxAdapter(child: _HeroSection()),

            // Quick Actions
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
              sliver: SliverToBoxAdapter(child: QuickActionsGrid()),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 24)),

            // Promo Carousel
            SliverToBoxAdapter(child: PromoBannerCarousel()),

            SliverToBoxAdapter(child: SizedBox(height: 24)),

            // Bill Categories
            SliverToBoxAdapter(child: BillCategoriesStrip()),

            SliverToBoxAdapter(child: SizedBox(height: 24)),

            // Recent Transactions
            SliverToBoxAdapter(child: RecentTransactionsSection()),

            SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.walletGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: const [
            HomeHeader(),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: WalletBalanceCard(),
            ),
          ],
        ),
      ),
    );
  }
}