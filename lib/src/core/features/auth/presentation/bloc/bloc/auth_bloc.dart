import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_strings.dart';
import 'package:smart_digital_wallet/src/core/features/auth/domain/usecases/signin_usecase.dart';
import 'package:smart_digital_wallet/src/core/features/auth/domain/usecases/authenticate_with_biometrics_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUsecase signInUsecase;
  final AuthenticateWithBiometricsUsecase authenticateWithBiometricsUsecase;

  AuthBloc({
    required this.signInUsecase,
    required this.authenticateWithBiometricsUsecase,
  }) : super(AuthState()) {
    on<SignInEvent>(_onSignInEventHandler);
    on<TogglePasswordVisibilityEvent>(_onTogglePasswordVisibilityEventHandler);
    on<AuthenticateWithBiometricsEvent>(_onAuthenticateWithBiometricsEvent);
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
  
  Future<void> _onAuthenticateWithBiometricsEvent(
    AuthenticateWithBiometricsEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(errorMessage: '', isBiometric: true, isSignInLoading: true));
    final result = await authenticateWithBiometricsUsecase(event.context);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            errorMessage: failure.message,
            isLoggedIn: false,
            isSignInLoading: false,
            isBiometric: false,
          ),
        );
      },
      (success) {
        if (success) {
          emit(
            state.copyWith(
              isLoggedIn: true,
              errorMessage: '',
              isSignInLoading: false,
              isBiometric: false,
            ),
          );
        } else {
          emit(
            state.copyWith(
              isSignInLoading: false,
              errorMessage: biometricAuthFailed,
              isLoggedIn: false,
              isBiometric: false,
            ),
          );
        }
      },
    );
  }
}
