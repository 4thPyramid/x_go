import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:x_go/client/features/auth/domain/usecases/forget_password_use_case.dart';
import 'package:x_go/client/features/auth/domain/usecases/login_usecase.dart';
import 'package:x_go/client/features/auth/domain/usecases/otp_usecase.dart';
import 'package:x_go/client/features/auth/domain/usecases/register_usecase.dart';
import 'package:x_go/client/features/auth/domain/usecases/reset_password_use_case.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final OtpUseCase otpUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  AuthCubit(
    this.loginUseCase,
    this.registerUseCase,
    this.forgetPasswordUseCase,
    this.otpUseCase,
    this.resetPasswordUseCase,
  ) : super(AuthInitial());

  Future<void> login(String email, String password, bool isRememberMe) async {
    emit(LoginLoading());
    try {
      final result = await loginUseCase.call(
        email: email,
        password: password,
        isRememberMe: isRememberMe,
      );
      result.fold(
        (l) => emit(LoginError(l.message)),
        (r) => emit(LoginSuccess('login success')),
      );
    } on DioException catch (e) {
      emit(LoginError(e.message.toString()));
    }
  }

  Future<void> register(
    String firstName,
    String lastName,
    String email,
    String password,
    String phone,
  ) async {
    emit(RegisterLoading());

    try {
      final result = await registerUseCase.call(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phone: phone,
      );
      result.fold(
        (l) => emit(RegisterError(l.message)),
        (r) => emit(RegisterSuccess(r.message)),
      );
    } on DioException catch (e) {
      emit(RegisterError(e.message.toString()));
    }
  }

  Future<void> forgetPassword(String email) async {
    emit(ForgotPasswordLoading());

    try {
      final result = await forgetPasswordUseCase.call(email: email);
      result.fold((l) => emit(ForgotPasswordError(l.message)), (r) {
        emit(ForgotPasswordSuccess(r.message));
      });
    } on DioException catch (e) {
      emit(ForgotPasswordError(e.message.toString()));
    }
  }

  Future<void> otp(String email, String otp) async {
    emit(OtpLoading());

    try {
      final result = await otpUseCase.call(email: email, otp: otp);
      result.fold(
        (l) => emit(OtpError(l.message)),
        (r) => emit(OtpSuccess(r.message)),
      );
    } on DioException catch (e) {
      emit(OtpError(e.message.toString()));
    }
  }

  Future<void> resetPassword(String email, String password, String otp) async {
    emit(ResetPasswordLoading());

    try {
      final result = await resetPasswordUseCase.call(
        email: email,
        password: password,
        otp: otp,
      );
      result.fold(
        (l) => emit(ResetPasswordError(l.message)),
        (r) => emit(ResetPasswordSuccess(r.message)),
      );
    } on DioException catch (e) {
      emit(ResetPasswordError(e.message.toString()));
    }
  }
}
