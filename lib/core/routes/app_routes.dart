import 'package:go_router/go_router.dart';
import 'package:my_project/core/routes/route_names.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RouteNames.login,
      // builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: RouteNames.dashboard,
      // builder: (context, state) => DashboardPage(),
    ),
  ],
);
