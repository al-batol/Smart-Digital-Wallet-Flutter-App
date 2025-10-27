import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_strings.dart';
import 'package:smart_digital_wallet/src/core/common/localization/localization_service.dart';

class BiometricService {
  final LocalAuthentication _localAuth;

  BiometricService({required LocalAuthentication localAuth})
    : _localAuth = localAuth;

  Future<bool> authenticateWithBiometrics(BuildContext context) async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _localAuth.authenticate(
        localizedReason: biometricAuthReason,
        persistAcrossBackgrounding: true,
        authMessages: <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: context.translate(biometricSignInTitle),
            signInHint: context.translate(biometricSignInHint),
            cancelButton: context.translate(biometricCancelButton),
          ),
        ],
        biometricOnly: true,
      );
      await Future.delayed(const Duration(seconds: 1));
    } on PlatformException catch (e) {
      throw e.message.toString();
    }
    return isAuthenticated;
  }

  Future<bool> hasBiometrics() async {
    bool supported = await _localAuth.isDeviceSupported();
    bool enrolled = (await _localAuth.getAvailableBiometrics()).isNotEmpty;
    return supported && enrolled;
  }
}
