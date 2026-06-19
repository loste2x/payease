import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../bill_payment/presentation/pages/bills_home_page.dart';
import '../../../cashback/presentation/pages/cashback_home_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../transactions/presentation/pages/transactions_page.dart';
import 'home_page.dart';

class MainWrapperPage extends StatefulWidget {
  const MainWrapperPage({super.key});

  @override
  State<MainWrapperPage> createState() => _MainWrapperPageState();
}

class _MainWrapperPageState extends State<MainWrapperPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    BillsHomePage(),
    TransactionsPage(),
    CashbackHomePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        backgroundColor: AppColors.surfaceContainer,
        indicatorColor: context.colors.primaryContainer,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long_rounded),
            label: 'Bills',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history_rounded),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_offer_outlined),
            selectedIcon: Icon(Icons.local_offer_rounded),
            label: 'Cashback',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}