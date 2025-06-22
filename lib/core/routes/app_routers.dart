import 'package:go_router/go_router.dart';
import 'package:x_go/app.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/features/auth/login/presentation/view/login_view.dart';
import 'package:x_go/features/splash/splash_view.dart';

final GoRouter router = GoRouter(
  initialLocation: RouterNames.login,
  routes: [
    GoRoute(
      path: RouterNames.home,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(path: RouterNames.app, builder: (context, state) => const App()),
    GoRoute(
      path: RouterNames.login,
      builder: (context, state) => const LoginView(),
    ),
  ],
);
