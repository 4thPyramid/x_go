import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/core/errors/exceptions.dart';
import 'package:x_go/delivery/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:x_go/delivery/features/auth/data/models/login_response_model.dart';
import 'package:x_go/delivery/features/auth/domain/entities/auth_response.dart';
import 'package:x_go/delivery/features/auth/domain/repositories/auth_repository.dart';


class DeliveryAuthRepositoryImpl implements DeliveryAuthRepository {
  final DeliveryAuthRemoteDataSource remoteDataSource;

  DeliveryAuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorModel, AuthResponse>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await remoteDataSource.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel(message: e.message.toString()));
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  
  @override
  Future<Either<ErrorModel, AuthResponse>> otp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await remoteDataSource.otp(email: email, otp: otp);
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel(message: e.message.toString()));
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, AuthResponse>> forgetPassword({
    required String email,
  }) async {
    try {
      final response = await remoteDataSource.forgetPassword(email: email);
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel(message: e.message.toString()));
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, AuthResponse>> resetPassword({
    required String email,
    required String password,
    required String otp,
  }) async {
    try {
      final response = await remoteDataSource.resetPassword(
        email: email,
        password: password,
        otp: otp,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel(message: e.message.toString()));
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, DriverModel>> login({required String email, required String password, required bool isRememberMe}) 
   async {
    try {
      final response = await remoteDataSource.login(
        email: email,
        password: password,
        isRememberMe: isRememberMe,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel(message: e.message.toString()));
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }
}
    
