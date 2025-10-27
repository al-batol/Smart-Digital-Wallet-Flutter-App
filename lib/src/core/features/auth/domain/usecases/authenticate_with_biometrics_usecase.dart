import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/features/auth/domain/repository/auth_repository.dart';
import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';

class AuthenticateWithBiometricsUsecase {
  final AuthRepository authRepository;

  AuthenticateWithBiometricsUsecase({required this.authRepository});

  Future<Result<bool>> call(BuildContext context) async {
    return await authRepository.authenticateWithBiometrics(context);
  }
}