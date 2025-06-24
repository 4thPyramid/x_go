import 'package:dartz/dartz.dart';
import 'package:x_go/core/data/cached/cache_helper.dart';
import 'package:x_go/core/errors/error_model.dart';
import '../../domain/entities/auth_response.dart';
import '../../domain/entities/login_response.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorModel, AuthResponse>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String location,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        location: location,
        password: password,
      );
      return Right(response);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.login(
        email: email,
        password: password,
      );
      CacheHelper.saveData(key: 'token', value: response);
      return Right(response);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
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
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, AuthResponse>> forgetPassword({
    required String email,
  }) async {
    try {
      final response = await remoteDataSource.forgetPassword(email: email);
      return Right(response);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
