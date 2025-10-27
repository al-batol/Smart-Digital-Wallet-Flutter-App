part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool isPasswordVisible;
  final bool isSignInLoading;
  final String errorMessage;
  final bool isLoggedIn;
  final bool isBiometric;
  const AuthState({
    this.isPasswordVisible = false,
    this.isSignInLoading = false,
    this.errorMessage = '',
    this.isLoggedIn = false,
    this.isBiometric = false,
  });

  @override
  List<Object> get props => [
    isPasswordVisible,
    isSignInLoading,
    errorMessage,
    isLoggedIn,
    isBiometric,
  ];

  AuthState copyWith({
    bool? isPasswordVisible,
    bool? isSignInLoading,
    String? errorMessage,
    bool? isLoggedIn,
    bool? isBiometric,
  }) {
    return AuthState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isSignInLoading: isSignInLoading ?? this.isSignInLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isBiometric: isBiometric ?? this.isBiometric,
    );
  }
}
