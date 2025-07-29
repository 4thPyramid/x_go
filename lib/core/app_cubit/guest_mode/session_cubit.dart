// session_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/core/app_cubit/guest_mode/enums.dart';
import 'package:x_go/core/app_cubit/guest_mode/session_state.dart';
import 'package:x_go/core/data/cached/cache_helper.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit() : super(const SessionState(status: AuthStatus.guest));

  Future<void> checkAuthStatus() async {
    final token = CacheHelper.getToken();

    if (token != null && token.isNotEmpty) {
      emit(const SessionState(status: AuthStatus.authenticated));
    } else {
      emit(const SessionState(status: AuthStatus.guest));
    }
  }

  void logout() {
    CacheHelper.deleteToken();
    emit(const SessionState(status: AuthStatus.guest));
  }
}
