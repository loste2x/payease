import 'package:go_router/go_router.dart';

import 'config/routes/route_names.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/otp_page.dart';
import 'features/home/presentation/pages/main_wrapper_page.dart';

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
    ],
  );
}