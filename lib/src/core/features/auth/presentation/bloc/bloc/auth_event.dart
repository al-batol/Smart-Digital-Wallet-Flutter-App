part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class TogglePasswordVisibilityEvent extends AuthEvent {
  const TogglePasswordVisibilityEvent();

  @override
  List<Object> get props => [];
}
