part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  final String message;

  LoginSuccess(this.message);
}

final class LoginError extends AuthState {
  final String message;

  LoginError(this.message);
}

final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {
  final String message;

  RegisterSuccess(this.message);
}

final class RegisterError extends AuthState {
  final String message;

  RegisterError(this.message);
}

final class ForgotPasswordLoading extends AuthState {}

final class ForgotPasswordSuccess extends AuthState {
  final String message;

  ForgotPasswordSuccess(this.message);
}

final class ForgotPasswordError extends AuthState {
  final String message;

  ForgotPasswordError(this.message);
}

final class OtpLoading extends AuthState {}

final class OtpSuccess extends AuthState {
  final String message;

  OtpSuccess(this.message);
}

final class OtpError extends AuthState {
  final String message;

  OtpError(this.message);
}

final class ResetPasswordLoading extends AuthState {}

final class ResetPasswordSuccess extends AuthState {
  final String message;

  ResetPasswordSuccess(this.message);
}

final class ResetPasswordError extends AuthState {
  final String message;

  ResetPasswordError(this.message);
}
