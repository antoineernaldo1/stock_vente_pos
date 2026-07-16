import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/sales/presentation/pages/pos_page.dart';

import '../features/authentication/presentation/pages/login_page.dart';
import '../features/authentication/presentation/pages/splash_page.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import 'routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,

    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),

      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        path: AppRoutes.dashboard,

        builder: (context, state) => const DashboardPage(),
      ),

      GoRoute(
        path: AppRoutes.pos,
        builder: (context, state) => const PosPage(),
      ),
    ],
  );
});
