import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:x_go/features/auth/domain/usecases/forget_password_use_case.dart';
import 'package:x_go/features/auth/domain/usecases/login_usecase.dart';
import 'package:x_go/features/auth/domain/usecases/register_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  AuthCubit(this.loginUseCase, this.registerUseCase, this.forgetPasswordUseCase)
    : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    try {
      final result = await loginUseCase.call(email: email, password: password);
      result.fold(
        (l) => emit(LoginError(l.message)),
        (r) => emit(LoginSuccess()),
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
    String location,
  ) async {
    emit(RegisterLoading());

    try {
      final result = await registerUseCase.call(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        location: location,
      );
      result.fold(
        (l) => emit(RegisterError(l.message)),
        (r) => emit(RegisterSuccess()),
      );
    } on DioException catch (e) {
      emit(RegisterError(e.message.toString()));
    }
  }

  Future<void> forgetPassword(String email) async {
    emit(ForgotPasswordLoading());

    try {
      final result = await forgetPasswordUseCase.call(email: email);
      result.fold(
        (l) => emit(ForgotPasswordError(l.message)),
        (r) => emit(ForgotPasswordSuccess()),
      );
    } on DioException catch (e) {
      emit(ForgotPasswordError(e.message.toString()));
    }
  }
}
