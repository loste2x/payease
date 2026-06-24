import 'package:go_router/go_router.dart';

import 'config/routes/route_names.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/otp_page.dart';
import 'features/home/presentation/pages/main_wrapper_page.dart';
import 'features/wallet/presentation/pages/add_money_page.dart';
import 'features/wallet/presentation/pages/payment_success_page.dart';
import 'features/wallet/presentation/pages/send_money_page.dart';
import 'features/wallet/presentation/pages/wallet_home_page.dart';
import 'features/wallet/presentation/pages/withdraw_page.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.login,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RouteNames.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouteNames.otp,
        name: 'otp',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final mobile = extra?['mobile'] as String? ?? '';
          return OtpPage(mobile: mobile);
        },
      ),
      GoRoute(
        path: RouteNames.home,
        name: 'home',
        builder: (context, state) => const MainWrapperPage(),
      ),

      // ─── Wallet Routes ───
      GoRoute(
        path: RouteNames.wallet,
        name: 'wallet',
        builder: (context, state) => const WalletHomePage(),
      ),
      GoRoute(
        path: RouteNames.addMoney,
        name: 'addMoney',
        builder: (context, state) => const AddMoneyPage(),
      ),
      GoRoute(
        path: RouteNames.sendMoney,
        name: 'sendMoney',
        builder: (context, state) => const SendMoneyPage(),
      ),
      GoRoute(
        path: RouteNames.withdraw,
        name: 'withdraw',
        builder: (context, state) => const WithdrawPage(),
      ),
      GoRoute(
        path: RouteNames.billReceipt,
        name: 'billReceipt',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return PaymentSuccessPage(
            amount: extra?['amount'] as int? ?? 0,
            refId: extra?['refId'] as String? ?? '',
            title: extra?['title'] as String? ?? 'Payment Successful!',
            receiver: extra?['receiver'] as String?,
          );
        },
      ),
    ],
  );
}