import 'package:smart_digital_wallet/src/core/common/result/exceptions.dart'
    show AuthException;
import 'package:smart_digital_wallet/src/core/common/services/api_client_service.dart';

abstract class AuthRemoteDataSource {
  Future<String> signIn({required String email, required String password});
  Future<void> signOut();
}

class AuthRemoteDataSourceImp extends AuthRemoteDataSource {
  final ApiClientService apiClientService;

  AuthRemoteDataSourceImp({required this.apiClientService});

  @override
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await apiClientService.post('https://api.com/auth/signin', {
        'email': email,
        'password': password,
      });
      if (email == email && password == password)
        return "jwt_token";
      else {
        throw AuthException(message: "Invalid email or password");
      }
    } catch (e) {
      throw AuthException(message: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
