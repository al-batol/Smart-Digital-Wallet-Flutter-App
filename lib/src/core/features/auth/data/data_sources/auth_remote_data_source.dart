import 'package:smart_digital_wallet/src/core/common/constants/app_constants.dart';
import 'package:smart_digital_wallet/src/core/common/helper/token_generator.dart';
import 'package:smart_digital_wallet/src/core/common/result/exceptions.dart'
    show AuthException;
import 'package:smart_digital_wallet/src/core/common/services/api_client_service.dart';
import 'package:smart_digital_wallet/src/core/common/services/network_connectivity_service.dart';

abstract class AuthRemoteDataSource {
  Future<String> signIn({required String email, required String password});
  Future<void> signOut();
}

class AuthRemoteDataSourceImp extends AuthRemoteDataSource {
  final ApiClientService apiClientService;
  final NetworkConnectivityService networkConnectivityService;

  AuthRemoteDataSourceImp({
    required this.apiClientService,
    required this.networkConnectivityService,
  });

  @override
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await networkConnectivityService.checkConnection(
        AuthException(message: 'check_internet_connection'),
      );

      await apiClientService.post('https://api.com/auth/signin', {
        'email': email,
        'password': password,
      });
      if (email == testEmail && password == testPassword) {
        return generateToken();
      } else {
        throw AuthException(message: "invalid_email_or_password");
      }
    } on AuthException {
      rethrow;
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
