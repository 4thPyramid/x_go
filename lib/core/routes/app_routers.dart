import 'package:go_router/go_router.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/features/home/presentation/view/home_view.dart';
import 'package:x_go/features/splash/splash_view.dart';
import 'package:x_go/main.dart';

final GoRouter router = GoRouter(
  initialLocation: RouterNames.home,
  routes: [
    GoRoute(
      path: RouterNames.home,
      builder: (context, state) => const SplashView(),
    ),
  ],
);
