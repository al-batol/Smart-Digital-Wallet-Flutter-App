import 'package:smart_digital_wallet/src/core/common/constants/app_constants.dart';
import 'package:smart_digital_wallet/src/core/common/services/secure_storage_service.dart';

abstract class AuthLocalDataSourse {
  Future<void> saveToken(String token);
}

class AuthLocalDataSourseImp implements AuthLocalDataSourse {
  final SecureStorageService secureStorageService;

  AuthLocalDataSourseImp({required this.secureStorageService});

  @override
  Future<void> saveToken(String token) async {
    await secureStorageService.writeString(tokenKey, token);
  }
}
