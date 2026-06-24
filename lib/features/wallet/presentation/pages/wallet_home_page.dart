import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/route_names.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../service_locator.dart';
import '../bloc/wallet_bloc.dart';
import '../bloc/wallet_event.dart';
import '../bloc/wallet_state.dart';

class WalletHomePage extends StatelessWidget {
  const WalletHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<WalletBloc>()..add(const LoadWalletBalance()),
      child: const _WalletView(),
    );
  }
}

class _WalletView extends StatelessWidget {
  const _WalletView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        title: const Text('My Wallet'),
        backgroundColor: AppColors.scaffoldBg,
      ),
      body: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              context.read<WalletBloc>().add(const LoadWalletBalance());
              await Future.delayed(const Duration(milliseconds: 600));
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _BalanceHero(state: state),
                const SizedBox(height: 20),
                _ActionGrid(),
                const SizedBox(height: 20),
                _LimitsCard(state: state),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BalanceHero extends StatelessWidget {
  final WalletState state;
  const _BalanceHero({required this.state});

  @override
  Widget build(BuildContext context) {
    int balance = 0;
    if (state is WalletLoaded) balance = (state as WalletLoaded).wallet.balance;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.walletGradient,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.heroDark.withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.account_balance_wallet_rounded,
                    color: Colors.white, size: 16),
              ),
              const SizedBox(width: 10),
              Text(
                'PayEase Wallet',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Available Balance',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          if (state is WalletLoading)
            const SizedBox(
              height: 50,
              child: Center(
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              ),
            )
          else
            Text(
              Formatters.currency(balance),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 42,
                fontWeight: FontWeight.w800,
                letterSpacing: -1,
              ),
            ),
        ],
      ),
    );
  }
}

class _ActionGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        children: [
          _Action(
            icon: Icons.add_rounded,
            label: 'Add\nMoney',
            gradient: AppColors.successGradient,
            onTap: () => context.push(RouteNames.addMoney),
          ),
          _Action(
            icon: Icons.arrow_outward_rounded,
            label: 'Send\nMoney',
            gradient: AppColors.primaryGradient,
            onTap: () => context.push(RouteNames.sendMoney),
          ),
          _Action(
            icon: Icons.account_balance_rounded,
            label: 'Withdraw\nto Bank',
            gradient: AppColors.blueGradient,
            onTap: () => context.push(RouteNames.withdraw),
          ),
          _Action(
            icon: Icons.history_rounded,
            label: 'History',
            gradient: AppColors.premiumGradient,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _Action extends StatelessWidget {
  final IconData icon;
  final String label;
  final Gradient gradient;
  final VoidCallback onTap;

  const _Action({
    required this.icon,
    required this.label,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LimitsCard extends StatelessWidget {
  final WalletState state;
  const _LimitsCard({required this.state});

  @override
  Widget build(BuildContext context) {
    int dailyLimit = 2500000;
    int dailySpent = 0;
    int monthlyLimit = 10000000;
    int monthlySpent = 0;

    if (state is WalletLoaded) {
      final w = (state as WalletLoaded).wallet;
      dailyLimit = w.dailyLimit;
      dailySpent = w.dailySpent;
      monthlyLimit = w.monthlyLimit;
      monthlySpent = w.monthlySpent;
    }

    return Container(
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
          const Text(
            '💳 Spending Limits',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          _LimitRow(label: 'Daily', spent: dailySpent, limit: dailyLimit),
          const SizedBox(height: 14),
          _LimitRow(label: 'Monthly', spent: monthlySpent, limit: monthlyLimit),
        ],
      ),
    );
  }
}

class _LimitRow extends StatelessWidget {
  final String label;
  final int spent;
  final int limit;

  const _LimitRow({required this.label, required this.spent, required this.limit});

  @override
  Widget build(BuildContext context) {
    final progress = limit > 0 ? spent / limit : 0.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurfaceVariant,
                )),
            const Spacer(),
            Text(
              '${Formatters.currency(spent)} / ${Formatters.currency(limit)}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: AppColors.surfaceContainerHigh,
            valueColor: AlwaysStoppedAnimation(
              progress > 0.8 ? AppColors.error : AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}