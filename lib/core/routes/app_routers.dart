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
import 'package:x_go/features/carBooking/data/model/book_car_model.dart';
import 'package:x_go/features/carBooking/presentation/logic/cubit/car_booking_cubit.dart';
import 'package:x_go/features/carBooking/presentation/views/car_booking_page.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';
import 'package:x_go/features/home/presentation/logic/cubit/active_location/active_location_cubit.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit/home_cubit.dart';
import 'package:x_go/features/home/presentation/view/home_view.dart';
import 'package:x_go/features/location/presentation/logic/cubit/location_cubit.dart';
import 'package:x_go/features/location/presentation/view/location_view.dart';
import 'package:x_go/features/my_bookings/data/models/booking_model.dart';
import 'package:x_go/features/my_bookings/presentation/logic/cubit/my_booking_cubit.dart';
import 'package:x_go/features/my_bookings/presentation/views/my_booking_view.dart';
import 'package:x_go/features/payment/presentation/logic/cubit/payment_cubit.dart';
import 'package:x_go/features/payment/presentation/views/payment_view.dart';
import 'package:x_go/features/profile/presentation/logic/cubit/profile_edit_cubit.dart';
import 'package:x_go/features/profile/presentation/views/profile_settings_details.dart';
import 'package:x_go/features/profile/presentation/views/profile_view.dart';
import 'package:x_go/features/splash/views/splash_view.dart';
import 'package:x_go/core/data/cached/cache_helper.dart';

final GoRouter router = GoRouter(
  initialLocation: CacheHelper.getData(key: 'isRememberMe') != null
      ? RouterNames.app
      : RouterNames.splash,

  routes: [
    GoRoute(
      path: RouterNames.splash,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: RouterNames.myBooking,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<MyBookingCubit>()..getBookingList(),
        child: const MyBookingView(),
      ),
    ),
    GoRoute(
      path: RouterNames.carBooking,
      builder: (context, state) {
        final car = state.extra as CarEntity;
        return BlocProvider(
          create: (context) => CarBookingCubit(),
          child: CarBookingPage(car: car),
        );
      },
    ),
    GoRoute(
      path: RouterNames.profileDetails,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<ProfileEditCubit>()..getProfileData(),
        child: const ProfileSettingsScreen(),
      ),
    ),

    // GoRoute(
    //   path: RouterNames.language,
    //   builder: (context, state) => BlocProvider(
    //     create: (context) => LocalizationCubit(),
    //     child: const LanguagePage(),
    //   ),
    // ),
    GoRoute(path: RouterNames.home, builder: (context, state) => HomeView()),

    GoRoute(
      path: RouterNames.app,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<HomeCubit>()),
          BlocProvider(create: (context) => getIt<ActiveLocationCubit>()),
        ],
        child: App(),
      ),
    ),

    GoRoute(
      path: RouterNames.forgotPassword,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => AuthCubit(
            getIt<LoginUseCase>(),
            getIt<RegisterUseCase>(),
            getIt<ForgetPasswordUseCase>(),
            getIt<OtpUseCase>(),
            getIt<ResetPasswordUseCase>(),
          ),
          child: ForgetPasswordView(),
        );
      },
    ),
    GoRoute(
      path: RouterNames.otp,
      builder: (context, state) {
        final email = state.extra as String;

        return BlocProvider(
          create: (context) => AuthCubit(
            getIt<LoginUseCase>(),
            getIt<RegisterUseCase>(),
            getIt<ForgetPasswordUseCase>(),
            getIt<OtpUseCase>(),
            getIt<ResetPasswordUseCase>(),
          ),
          child: OtpView(email: email),
        );
      },
    ),
    GoRoute(
      path: RouterNames.resetPassword,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        final email = data['email'];
        final otp = data['otp'];

        return BlocProvider(
          create: (context) => AuthCubit(
            getIt<LoginUseCase>(),
            getIt<RegisterUseCase>(),
            getIt<ForgetPasswordUseCase>(),
            getIt<OtpUseCase>(),
            getIt<ResetPasswordUseCase>(),
          ),
          child: ResetPasswordView(email: email, otp: otp),
        );
      },
    ),
    GoRoute(
      path: RouterNames.success_updated,
      builder: (context, state) => const SuccessUpdatedView(),
    ),

    GoRoute(
      path: RouterNames.location,
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => LocationCubit()),
            BlocProvider(create: (context) => CarBookingCubit()),
          ],
          child: const LocationView(),
        );
      },
    ),

    GoRoute(
      path: RouterNames.carDetails,
      builder: (context, state) {
        final car =
            state.extra
                as CarEntity; // Pass the car object via state.extra when navigating
        return CarDetailsPage(car: car);
      },
    ),
    GoRoute(
      path: RouterNames.app,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<ProfileEditCubit>()..getProfileData(),
        child: App(),
      ),
    ),
    GoRoute(
      path: RouterNames.auth,
      builder: (context, state) {
        final extra = state.extra as int;
        return BlocProvider(
          create: (context) => AuthCubit(
            getIt<LoginUseCase>(),
            getIt<RegisterUseCase>(),
            getIt<ForgetPasswordUseCase>(),
            getIt<OtpUseCase>(),
            getIt<ResetPasswordUseCase>(),
          ),
          child: AuthView(index: extra),
        );
      },
    ),
    // GoRoute(
    //   path: RouterNames.carDetails,
    //   builder: (context, state) => const CarDetailsPage(
    //
    //   ),
    // ),
    GoRoute(
      path: RouterNames.profile,
      builder: (context, state) {
        return !isGuest ? const ProfilePage() : const AuthView(index: 0);
      },
    ),
  GoRoute(
  path: RouterNames.payment,
  builder: (context, state) {
    final args = state.extra as Map<String, dynamic>;
    
    final CarEntity? car = args['car'] as CarEntity?;
    final BookingModel? bookingModel = args['model'] as BookingModel?;
    final MyBookingModel? myBookingModel = args['myBookingModel'] as MyBookingModel?;

    return BlocProvider(
      create: (context) => PaymentCubit(),
      child: PaymentView(
        car: car,
        bookingModel: bookingModel,
        myBookingModel: myBookingModel,
      ),
    );
  },
)
  ],
);
