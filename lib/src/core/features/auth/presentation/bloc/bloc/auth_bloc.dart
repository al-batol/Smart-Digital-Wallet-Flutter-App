import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/features/auth/domain/usecases/signin_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUsecase signInUsecase;

  AuthBloc({required this.signInUsecase}) : super(AuthState()) {
    on<SignInEvent>(_onSignInEventHandler);
    on<TogglePasswordVisibilityEvent>(_onTogglePasswordVisibilityEventHandler);
  }

  Future<void> _onTogglePasswordVisibilityEventHandler(
    TogglePasswordVisibilityEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> _onSignInEventHandler(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isSignInLoading: true, errorMessage: ''));
    final result = await signInUsecase(
      email: event.email,
      password: event.password,
    );
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isSignInLoading: false,
            errorMessage: failure.message,
            isLoggedIn: false,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            isSignInLoading: false,
            isLoggedIn: true,
            errorMessage: '',
          ),
        );
      },
    );
  }
}
