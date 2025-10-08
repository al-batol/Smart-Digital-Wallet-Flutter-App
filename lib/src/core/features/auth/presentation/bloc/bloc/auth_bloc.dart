import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<TogglePasswordVisibilityEvent>(_onTogglePasswordVisibilityEventHandler);
  }

  Future<void> _onTogglePasswordVisibilityEventHandler(
    TogglePasswordVisibilityEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }
}
