// session_state.dart
import 'package:x_go/core/app_cubit/guest_mode/enums.dart';

class SessionState {
  final AuthStatus status;

  const SessionState({required this.status});

  SessionState copyWith({AuthStatus? status}) {
    return SessionState(status: status ?? this.status);
  }

  @override
  String toString() => 'SessionState(status: $status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SessionState && other.status == status;
  }

  @override
  int get hashCode => status.hashCode;
}
