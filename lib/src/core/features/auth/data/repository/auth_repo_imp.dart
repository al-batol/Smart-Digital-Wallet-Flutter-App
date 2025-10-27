import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/result/exceptions.dart';
import 'package:smart_digital_wallet/src/core/common/result/failure.dart';
import 'package:smart_digital_wallet/src/core/common/services/biometric_service.dart';
import 'package:smart_digital_wallet/src/core/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/auth/domain/repository/auth_repository.dart';
import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';

class AuthRepoImp implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSourse authLocalDataSourse;
  final BiometricService biometricService;
  
  AuthRepoImp({
    required this.authRemoteDataSource,
    required this.authLocalDataSourse,
    required this.biometricService,
  });

  @override
  Future<Result<String>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final token = await authRemoteDataSource.signIn(
        email: email,
        password: password,
      );
      await authLocalDataSourse.saveToken(token);
      return Right(token);
    } on AuthException catch (e) {
      return left(AuthFailure(message: e.message));
    }
  }
  
  @override
  Future<Result<bool>> authenticateWithBiometrics(BuildContext context) async {
    try {
      final isAuthenticated = await biometricService.authenticateWithBiometrics(context);
      return Right(isAuthenticated);
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<ResultVoid> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
