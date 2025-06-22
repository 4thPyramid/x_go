import 'package:go_router/go_router.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/features/home/presentation/view/home_view.dart';
import 'package:x_go/features/profile/presentation/views/profile_view.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RouterNames.home,
      builder: (context, state) => const HomeView(),
    ), GoRoute(
      path: RouterNames.profile,
      builder: (context, state) => const ProfilePage(),
    ),
  ],
);
