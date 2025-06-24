import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:x_go/core/data/api/dio_consumer.dart';
import 'package:x_go/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:x_go/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:x_go/features/auth/domain/usecases/login_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    final loginUseCase = LoginUseCase(
      AuthRepositoryImpl(
        remoteDataSource: AuthRemoteDataSourceImpl(
          apiConsumer: DioConsumer(dio: Dio()),
        ),
      ),
    );
    try {
      await loginUseCase.call(email: email, password: password);
      emit(LoginSuccess());
    } on DioException catch (e) {
      emit(LoginError(e.message.toString()));
    }
  }
}
