import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/app.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/services/service_locator.dart';
import 'package:x_go/features/auth/domain/usecases/forget_password_use_case.dart';
import 'package:x_go/features/auth/domain/usecases/login_usecase.dart';
import 'package:x_go/features/auth/domain/usecases/register_usecase.dart';
import 'package:x_go/features/auth/presentation/logic/cubit/auth_cubit.dart';
import 'package:x_go/features/auth/presentation/view/auth_view.dart';
import 'package:x_go/features/auth/presentation/view/forget_password_view.dart';
import 'package:x_go/features/auth/presentation/view/otpview.dart';
import 'package:x_go/features/auth/presentation/view/reset_password_view.dart';
import 'package:x_go/features/auth/presentation/view/success_updated_view.dart';
import 'package:x_go/features/home/presentation/view/home_view.dart';
import 'package:x_go/features/splash/splash_view.dart';

final GoRouter router = GoRouter(
  initialLocation: RouterNames.login,
  routes: [
    GoRoute(
      path: RouterNames.splash,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: RouterNames.home,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(path: RouterNames.app, builder: (context, state) => const App()),
    GoRoute(
      path: RouterNames.login,
      builder: (context, state) => BlocProvider(
        create: (context) => AuthCubit(
          getIt<LoginUseCase>(),
          getIt<RegisterUseCase>(),
          getIt<ForgetPasswordUseCase>(),
        ),
        child: const AuthView(),
      ),
    ),
    GoRoute(
      path: RouterNames.forgotPassword,
      builder: (context, state) => BlocProvider(
        create: (context) => AuthCubit(
          getIt<LoginUseCase>(),
          getIt<RegisterUseCase>(),
          getIt<ForgetPasswordUseCase>(),
        ),
        child: const ForgetPasswordView(),
      ),
    ),
    GoRoute(
      path: RouterNames.otp,
      builder: (context, state) => const OtpView(),
    ),
    GoRoute(
      path: RouterNames.resetPassword,
      builder: (context, state) => const ResetPasswordView(),
    ),
    GoRoute(
      path: RouterNames.success_updated,
      builder: (context, state) => const SuccessUpdatedView(),
    ),
  ],
);
