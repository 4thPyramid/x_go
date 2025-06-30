import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/app.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/services/service_locator.dart';
import 'package:x_go/features/Details/presentation/views/car_detail_view.dart';
import 'package:x_go/features/auth/domain/usecases/forget_password_use_case.dart';
import 'package:x_go/features/auth/domain/usecases/login_usecase.dart';
import 'package:x_go/features/auth/domain/usecases/otp_usecase.dart';
import 'package:x_go/features/auth/domain/usecases/register_usecase.dart';
import 'package:x_go/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:x_go/features/auth/presentation/logic/cubit/auth_cubit.dart';
import 'package:x_go/features/auth/presentation/view/auth_view.dart';
import 'package:x_go/features/auth/presentation/view/forget_password_view.dart';
import 'package:x_go/features/auth/presentation/view/otpview.dart';
import 'package:x_go/features/auth/presentation/view/reset_password_view.dart';
import 'package:x_go/features/auth/presentation/view/success_updated_view.dart';
import 'package:x_go/features/home/presentation/view/home_view.dart';
import 'package:x_go/features/language/presentation/view/language_view.dart';
import 'package:x_go/features/payment/presentation/views/payment_view.dart';
import 'package:x_go/features/profile/presentation/views/profile_settings_details.dart';
import 'package:x_go/features/profile/presentation/views/profile_view.dart';
import 'package:x_go/features/splash/views/splash_view.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RouterNames.splash,
      builder: (context, state) => const SplashView(),
    ),GoRoute(
      path: RouterNames.profileDetails,
      builder: (context, state) => const ProfileSettingsScreen(),
    ),
    GoRoute(
      path: RouterNames.language,
      builder: (context, state) => const LanguagePage(),
    ),
    GoRoute(
      path: RouterNames.home,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(path: RouterNames.app, builder: (context, state) => App()),
    GoRoute(
      path: RouterNames.login,
      builder: (context, state) => BlocProvider(
        create: (context) => AuthCubit(
          getIt<LoginUseCase>(),
          getIt<RegisterUseCase>(),
          getIt<ForgetPasswordUseCase>(),
          getIt<OtpUseCase>(),
          getIt<ResetPasswordUseCase>(),
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
          getIt<OtpUseCase>(),
          getIt<ResetPasswordUseCase>(),
        ),
        child: const ForgetPasswordView(),
      ),
    ),
    GoRoute(
      path: RouterNames.otp,
      builder: (context, state) => BlocProvider(
        create: (context) => AuthCubit(
          getIt<LoginUseCase>(),
          getIt<RegisterUseCase>(),
          getIt<ForgetPasswordUseCase>(),
          getIt<OtpUseCase>(),
          getIt<ResetPasswordUseCase>(),
        ),
        child: OtpView(email: 'e@gmail.com'),
      ),
    ),
    GoRoute(
      path: RouterNames.resetPassword,
      builder: (context, state) => BlocProvider(
        create: (context) => AuthCubit(
          getIt<LoginUseCase>(),
          getIt<RegisterUseCase>(),
          getIt<ForgetPasswordUseCase>(),
          getIt<OtpUseCase>(),
          getIt<ResetPasswordUseCase>(),
        ),
        child: const ResetPasswordView(),
      ),
    ),
    GoRoute(
      path: RouterNames.success_updated,
      builder: (context, state) => const SuccessUpdatedView(),
    ),
    GoRoute(path: RouterNames.app, builder: (context, state) => App()),
    GoRoute(
      path: RouterNames.carDetails,
      builder: (context, state) => const CarDetailsPage(),
    ),
    GoRoute(
      path: RouterNames.profile,
      builder: (context, state) => const ProfilePage(),
    ),
     GoRoute(
      path: RouterNames.payment,
      builder: (context, state) => const PaymentScreen(),
    ),
  ],
);
