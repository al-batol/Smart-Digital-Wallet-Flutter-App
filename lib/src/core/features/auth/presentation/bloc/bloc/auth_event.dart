part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class TogglePasswordVisibilityEvent extends AuthEvent {
  const TogglePasswordVisibilityEvent();
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
