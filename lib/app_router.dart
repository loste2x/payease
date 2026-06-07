import 'package:go_router/go_router.dart';
import 'config/routes/route_names.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/otp_page.dart';
import 'features/home/presentation/pages/home_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.login,
    routes: [
      GoRoute(path: RouteNames.login, builder: (context, state) => const LoginPage()),
      GoRoute(
        path: RouteNames.otp,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return OtpPage(mobile: extra?['mobile'] as String? ?? '');
        },
      ),
      GoRoute(path: RouteNames.home, builder: (context, state) => const HomePage()),
    ],
  );
}
