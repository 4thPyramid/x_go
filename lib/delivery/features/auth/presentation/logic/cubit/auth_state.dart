part of 'auth_cubit.dart';

@immutable
sealed class DeliveryAuthState {}

final class AuthInitial extends DeliveryAuthState {}

final class LoginLoading extends DeliveryAuthState {}

final class LoginSuccess extends DeliveryAuthState {
  final String message;

  LoginSuccess(this.message);
}

final class LoginError extends DeliveryAuthState {
  final String message;

  LoginError(this.message);
}

final class RegisterLoading extends DeliveryAuthState {}

final class RegisterSuccess extends DeliveryAuthState {
  final String message;

  RegisterSuccess(this.message);
}

final class RegisterError extends DeliveryAuthState {
  final String message;

  RegisterError(this.message);
}

final class ForgotPasswordLoading extends DeliveryAuthState {}

final class ForgotPasswordSuccess extends DeliveryAuthState {
  final String message;

  ForgotPasswordSuccess(this.message);
}

final class ForgotPasswordError extends DeliveryAuthState {
  final String message;

  ForgotPasswordError(this.message);
}

final class OtpLoading extends DeliveryAuthState {}

final class OtpSuccess extends DeliveryAuthState {
  final String message;

  OtpSuccess(this.message);
}

final class OtpError extends DeliveryAuthState {
  final String message;

  OtpError(this.message);
}

final class ResetPasswordLoading extends DeliveryAuthState {}

final class ResetPasswordSuccess extends DeliveryAuthState {
  final String message;

  ResetPasswordSuccess(this.message);
}

final class ResetPasswordError extends DeliveryAuthState {
  final String message;

  ResetPasswordError(this.message);
}
