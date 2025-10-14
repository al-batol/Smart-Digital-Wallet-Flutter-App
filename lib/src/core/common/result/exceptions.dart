import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable implements Exception {
  const AppException({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class AuthException extends AppException {
  const AuthException({required super.message});
}

class DashboardException extends AppException {
  const DashboardException({required super.message});
}
