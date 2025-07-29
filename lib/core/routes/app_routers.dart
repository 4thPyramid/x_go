import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/client/features/app.dart';
import 'package:x_go/client/features/client_tracking/presentation/logic/cubit/client_tracking_cubit.dart';
import 'package:x_go/client/features/client_tracking/presentation/view/client_tracking_view.dart';
import 'package:x_go/core/app_cubit/guest_mode/session_cubit.dart';
import 'package:x_go/core/data/cached/cache_helper.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/services/service_locator.dart';
import 'package:x_go/delivery/features/orderDetails/domain/entities/booking_entity.dart';
import 'package:x_go/delivery/features/profile/presentation/logic/update_profile/update_profile_cubit.dart';
import 'package:x_go/client/features/Details/presentation/logic/cubit/car_detail_cubit.dart';
import 'package:x_go/client/features/Details/presentation/views/car_detail_view.dart';
import 'package:x_go/client/features/auth/domain/usecases/forget_password_use_case.dart';
import 'package:x_go/client/features/auth/domain/usecases/login_usecase.dart';
import 'package:x_go/client/features/auth/domain/usecases/otp_usecase.dart';
import 'package:x_go/client/features/auth/domain/usecases/register_usecase.dart';
import 'package:x_go/client/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:x_go/client/features/auth/presentation/logic/cubit/auth_cubit.dart';
import 'package:x_go/client/features/auth/presentation/view/auth_view.dart';
import 'package:x_go/client/features/auth/presentation/view/forget_password_view.dart';
import 'package:x_go/client/features/auth/presentation/view/otpview.dart';
import 'package:x_go/client/features/auth/presentation/view/reset_password_view.dart';
import 'package:x_go/client/features/auth/presentation/view/success_updated_view.dart';
import 'package:x_go/client/features/carBooking/data/model/book_car_model.dart';
import 'package:x_go/client/features/carBooking/presentation/logic/cubit/car_booking_cubit.dart';
import 'package:x_go/client/features/carBooking/presentation/views/car_booking_page.dart';
import 'package:x_go/client/features/home/domain/entity/car_entity.dart';
import 'package:x_go/client/features/home/presentation/logic/cubit/active_location/active_location_cubit.dart';
import 'package:x_go/client/features/home/presentation/logic/cubit/home_cubit/home_cubit.dart';
import 'package:x_go/client/features/home/presentation/view/home_view.dart';
import 'package:x_go/client/features/home/presentation/view/popular_cars.dart';
import 'package:x_go/client/features/location/presentation/logic/cubit/location_cubit.dart';
import 'package:x_go/client/features/location/presentation/view/location_view.dart';
import 'package:x_go/client/features/my_bookings/data/models/booking_model.dart';
import 'package:x_go/client/features/my_bookings/presentation/logic/cubit/my_booking_cubit.dart';
import 'package:x_go/client/features/my_bookings/presentation/views/my_booking_view.dart';
import 'package:x_go/client/features/payment/presentation/logic/cubit/payment_cubit.dart';
import 'package:x_go/client/features/payment/presentation/views/payment_view.dart';
import 'package:x_go/client/features/profile/presentation/logic/cubit/profile_edit_cubit.dart';
import 'package:x_go/client/features/profile/presentation/views/profile_settings_details.dart';
import 'package:x_go/client/features/profile/presentation/views/profile_view.dart';
import 'package:x_go/client/features/review/presentation/logic/cubit/review_cubit.dart';
import 'package:x_go/client/features/review/presentation/views/review_view.dart';
import 'package:x_go/client/features/splash/views/splash_view.dart';
import 'package:x_go/delivery/features/auth/domain/usecases/forget_password_use_case.dart';
import 'package:x_go/delivery/features/auth/domain/usecases/login_usecase.dart';
import 'package:x_go/delivery/features/auth/domain/usecases/otp_usecase.dart';
import 'package:x_go/delivery/features/auth/domain/usecases/register_usecase.dart';
import 'package:x_go/delivery/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:x_go/delivery/features/auth/presentation/logic/cubit/auth_cubit.dart';
import 'package:x_go/delivery/features/auth/presentation/view/auth_view.dart';
import 'package:x_go/delivery/features/auth/presentation/view/forget_password_view.dart';
import 'package:x_go/delivery/features/auth/presentation/view/otpview.dart';
import 'package:x_go/delivery/features/auth/presentation/view/reset_password_view.dart';
import 'package:x_go/delivery/features/app_delivery.dart';
import 'package:x_go/delivery/features/delivery_location/presentation/logic/cubit/delivery_location_cubit.dart';
import 'package:x_go/delivery/features/delivery_location/presentation/view/delivery_location_view.dart';
import 'package:x_go/delivery/features/home/presentation/logic/accepted_status_cubit/oreder_status_cubit.dart';
import 'package:x_go/delivery/features/home/presentation/logic/completed_status_cubit/new_order_cubit/completed_status_cubit.dart';
import 'package:x_go/delivery/features/home/presentation/logic/new_order_cubit/new_status_cubit.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/home/custom_search_widget.dart';
import 'package:x_go/delivery/features/orderDetails/presentation/logic/booking_cubit.dart';
import 'package:x_go/delivery/features/orderDetails/presentation/views/order_details_view.dart';
import 'package:x_go/delivery/features/profile/presentation/logic/profile_info_cubit/driver_profile_info_cubit.dart';
import 'package:x_go/delivery/features/profile/presentation/views/profile_update_view.dart';
import 'package:x_go/user_type.dart';

final GoRouter router = GoRouter(
  initialLocation: RouterNames.userType,
  redirect: (context, state) {
    final token = CacheHelper.getToken();
    final driverId = CacheHelper.getDriverId();
    final isInitialPath =
        state.fullPath == RouterNames.userType ||
        state.fullPath == RouterNames.splash;

    if (!isInitialPath) return null;

    if (driverId != null && driverId.isNotEmpty) {
      return RouterNames.appDelivery;
    } else if (token != null && token.isNotEmpty) {
      return RouterNames.app;
    }

    return null;
  },

  routes: [
    GoRoute(
      path: RouterNames.appDelivery,
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) =>
                  getIt<AcceptedOrdersCubit>()..fetchAcceptedOrders(),
            ),
            BlocProvider(
              create: (_) => getIt<NewOrdersCubit>()..fetchNewOrders(),
            ),
            BlocProvider(
              create: (_) =>
                  getIt<CompletedOrdersCubit>()..fetchCompletedOrders(),
            ),
            BlocProvider(
              create: (_) =>
                  getIt<DriverProfileInfoCubit>()..fetchDriverProfile(),
            ),
          ],
          child: const AppDelivery(),
        );
      },
    ),
    GoRoute(
      path: RouterNames.driverDetails,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                getIt<DriverProfileInfoCubit>()..fetchDriverProfile(),
          ),
          BlocProvider(create: (context) => getIt<UpdateProfileCubit>()),
        ],
        child: const DriverUpdateDetailsView(),
      ),
    ),
    GoRoute(
      path: RouterNames.customSearchDeliveryApp,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<NewOrdersCubit>()..fetchNewOrders(),
        child: const CustomSearchDeliveryApp(),
      ),
    ),
    GoRoute(
      path: RouterNames.userType,
      builder: (context, state) => const UserTypeView(),
    ),
    GoRoute(
      path: RouterNames.splash,
      builder: (context, state) => const SplashView(),
    ),

    GoRoute(
      path: RouterNames.clientTrackLocation,
      builder: (context, state) => BlocProvider(
        create: (context) =>
            ClientTrackingCubit()..getLiveTrackingFromFirebase(),
        child: const ClientTrackingView(),
      ),
    ),
    GoRoute(
      path: RouterNames.popularCars,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<HomeCubit>(),
        child: const PopularCarsView(),
      ),
    ),
    GoRoute(
      path: RouterNames.myBooking,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<MyBookingCubit>()..getBookingList(),
          ),
          BlocProvider(create: (context) => PaymentCubit()),
        ],
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
      path: RouterNames.deliveryForgotPassword,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => DeliveryAuthCubit(
            getIt<DeliveryLoginUseCase>(),
            getIt<DeliveryRegisterUseCase>(),
            getIt<DeliveryForgetPasswordUseCase>(),
            getIt<DeliveryOtpUseCase>(),
            getIt<DeliveryResetPasswordUseCase>(),
          ),
          child: DeliveryForgetPasswordView(),
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
      path: RouterNames.deliveryOtp,
      builder: (context, state) {
        final email = state.extra as String;

        return BlocProvider(
          create: (context) => DeliveryAuthCubit(
            getIt<DeliveryLoginUseCase>(),
            getIt<DeliveryRegisterUseCase>(),
            getIt<DeliveryForgetPasswordUseCase>(),
            getIt<DeliveryOtpUseCase>(),
            getIt<DeliveryResetPasswordUseCase>(),
          ),
          child: DeliveryOtpView(email: email),
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
      path: RouterNames.deliveryResetPassword,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        final email = data['email'];
        final otp = data['otp'];

        return BlocProvider(
          create: (context) => DeliveryAuthCubit(
            getIt<DeliveryLoginUseCase>(),
            getIt<DeliveryRegisterUseCase>(),
            getIt<DeliveryForgetPasswordUseCase>(),
            getIt<DeliveryOtpUseCase>(),
            getIt<DeliveryResetPasswordUseCase>(),
          ),
          child: DeliveryResetPasswordView(email: email, otp: otp),
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
        final carId = state.extra as String;
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<CarDetailCubit>()),
          ],
          child: CarDetailsPage(carId: carId),
        );
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
      path: RouterNames.review,
      builder: (context, state) => BlocProvider(
        create: (context) =>
            ReviewCubit()..getReviews(int.parse(state.extra as String)),
        child: ReviewView(id: int.parse(state.extra as String)),
      ),
    ),
    GoRoute(
      path: RouterNames.payment,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;

        final CarEntity? car = args['car'] as CarEntity?;
        final BookingModel? bookingModel = args['model'] as BookingModel?;
        final MyBookingModel? myBookingModel =
            args['myBookingModel'] as MyBookingModel?;

        return BlocProvider(
          create: (context) => PaymentCubit(),
          child: PaymentView(
            car: car,
            bookingModel: bookingModel,
            myBookingModel: myBookingModel,
          ),
        );
      },
    ),
    GoRoute(
      path: RouterNames.deliveryLocation,
      builder: (context, state) {
        final booking = state.extra as BookingEntity;
        final modelId = booking.carModel.id;
        final bookingId = booking.id.toString();
        final driverId = booking.user.id.toString();
        final lat = booking.location?.latitude.toString() ?? '0';
        final lng = booking.location?.longitude.toString() ?? '0';
        final location = booking.location?.address ?? '';
        return BlocProvider(
          create: (context) => DeliveryLocationCubit()..getCurrentLocation(),
          child: DeliveryLocationView(
            modelId: modelId,
            bookingId: bookingId,
            driverId: driverId,
            lat: lat,
            lng: lng,
            location: location,
          ),
        );
      },
    ),
    GoRoute(
      path: RouterNames.delivery,
      builder: (context, state) {
        // Safely handle null or non-integer state.extra
        final extra = state.extra != null ? state.extra as int? : 0;
        return BlocProvider(
          create: (context) => DeliveryAuthCubit(
            getIt<DeliveryLoginUseCase>(),
            getIt<DeliveryRegisterUseCase>(),
            getIt<DeliveryForgetPasswordUseCase>(),
            getIt<DeliveryOtpUseCase>(),
            getIt<DeliveryResetPasswordUseCase>(),
          ),
          child: DeliveryAuthView(index: extra ?? 0),
        );
      },
    ),
    GoRoute(
      path: '${RouterNames.orderDetails}/:bookingId',
      builder: (context, state) {
        final bookingIdString = state.pathParameters['bookingId'];
        final bookingId = int.tryParse(bookingIdString ?? '0') ?? 0;
        return BlocProvider(
          create: (context) => getIt<BookingDetailsCubit>(),
          child: OrderDetailsView(bookingId: bookingId),
        );
      },
    ),
    GoRoute(
      path: RouterNames.profileDelivery,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<ProfileEditCubit>()..getProfileData(),
        child: const ProfilePage(),
      ),
    ),
    /* GoRoute(
      path: RouterNames.guestMode,
      builder: (context, state) => const GuestModeApp(),
    ),*/
  ],
);
