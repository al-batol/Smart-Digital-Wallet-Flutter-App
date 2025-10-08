part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool isPasswordVisible;
  const AuthState({this.isPasswordVisible = false});

  @override
  List<Object> get props => [isPasswordVisible];

  AuthState copyWith({bool? isPasswordVisible}) {
    return AuthState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}
