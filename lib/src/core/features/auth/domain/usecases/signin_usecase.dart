import 'package:smart_digital_wallet/src/core/features/auth/domain/repository/auth_repository.dart';
import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';

class SignInUsecase {
  final AuthRepository authRepository;

  SignInUsecase({required this.authRepository});

  Future<Result<String>> call({
    required String email,
    required String password,
  }) async {
    return await authRepository.signIn(email: email, password: password);
  }
}
