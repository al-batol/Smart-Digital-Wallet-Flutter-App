import 'package:dartz/dartz.dart';
import 'package:smart_digital_wallet/src/core/common/result/exceptions.dart';
import 'package:smart_digital_wallet/src/core/common/result/failure.dart';
import 'package:smart_digital_wallet/src/core/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/auth/domain/repository/auth_repository.dart';
import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';

class AuthRepoImp implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSourse authLocalDataSourse;
  AuthRepoImp({
    required this.authRemoteDataSource,
    required this.authLocalDataSourse,
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
  Future<ResultVoid> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
