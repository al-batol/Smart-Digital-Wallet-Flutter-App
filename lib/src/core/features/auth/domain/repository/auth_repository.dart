import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';

abstract class AuthRepository {
  Future<Result<String>> signIn({
    required String email,
    required String password,
  });
  Future<ResultVoid> signOut();
}
