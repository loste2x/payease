import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';
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
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 800));
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: const [
              // Header (greeting + notifications)
              SliverToBoxAdapter(
                child: HomeHeader(),
              ),

              // Wallet Balance Card
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.lg),
                sliver: SliverToBoxAdapter(
                  child: WalletBalanceCard(),
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(height: AppSizes.xl),
              ),

              // Quick Actions Grid
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.lg),
                sliver: SliverToBoxAdapter(
                  child: QuickActionsGrid(),
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(height: AppSizes.xl),
              ),

              // Promo / Cashback Offers Carousel
              SliverToBoxAdapter(
                child: PromoBannerCarousel(),
              ),

              SliverToBoxAdapter(
                child: SizedBox(height: AppSizes.xl),
              ),

              // Bill Categories
              SliverToBoxAdapter(
                child: BillCategoriesStrip(),
              ),

              SliverToBoxAdapter(
                child: SizedBox(height: AppSizes.xl),
              ),

              // Recent Transactions
              SliverToBoxAdapter(
                child: RecentTransactionsSection(),
              ),

              SliverToBoxAdapter(
                child: SizedBox(height: AppSizes.xxxl),
              ),
            ],
          ),
        ),
      ),
    );
  }
}