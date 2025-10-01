import 'package:smart_digital_wallet/src/core/features/auth/domain/repository/auth_repository.dart';
import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';

class SignOutUsecase {
  final AuthRepository authRepository;

  SignOutUsecase({required this.authRepository});

  Future<ResultVoid> call() async {
    return await authRepository.signOut();
  }
}
