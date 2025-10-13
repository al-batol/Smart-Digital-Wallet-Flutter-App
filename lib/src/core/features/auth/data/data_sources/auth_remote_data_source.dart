import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_constants.dart';
import 'package:smart_digital_wallet/src/core/common/helper/token_generator.dart';
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
      if (email == testEmail && password == testPassword) {
        return generateToken();
      } else {
        throw AuthException(message: "Invalid email or password");
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
